//
//  TreViewModel.swift
//  DocDocs2
//
//  Created by Евгений Солохин on 31.05.2023.
//

import SwiftUI

@MainActor
class TreViewModel: ObservableObject {
    
    // replace with your image model
    //@Published var allImages : [String] = ["1", "2", "3", "4", "5"]
    @Published var visits: [DocVisitModel] = [
        DocVisitModel(docName: "Irina Popova", date: "11.04.2023", images: ["1", "2"]),
        DocVisitModel(docName: "Maria Petrova", date: "22.05.2023", images: ["3", "4"]),
        DocVisitModel(docName: "Maria Petrova", date: "22.05.2023", images: ["3", "4"])
    ]
    
    // properties for image viewer
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    
    
    @Published var imageViewerOffset: CGSize = .zero
    
    // bg opacity
    @Published var bgOpacity: Double = 1
    
    // scaling
    @Published var imageScale: CGFloat = 1
    
    func onChange(value: CGSize){
        // updating offset
        imageViewerOffset = value
        
        // calculating opacity
        let halgHeight = UIScreen.main.bounds.height / 2
        let progress = imageViewerOffset.height / halgHeight
        
        withAnimation(.default){
            bgOpacity = Double(1 - (progress < 0 ? -progress : progress))
        }
    }
    
    func onEnd(value: DragGesture.Value){
        withAnimation(.easeInOut){
            var translation = value.translation.height
            
            if translation < 0 {
                translation = -translation
            }
            
            if translation < 250 {
                imageViewerOffset = .zero
                bgOpacity = 1
            }else{
                showImageViewer.toggle()
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}
