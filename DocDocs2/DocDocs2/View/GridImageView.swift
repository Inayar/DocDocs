//
//  GridImageView.swift
//  DocDocs2
//
//  Created by Евгений Солохин on 31.05.2023.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var homeData: TreViewModel
    var index: Int
    var currentVisit: DocVisitModel
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                // for page tab view automating scrolling
              
                homeData.selectedImageID = currentVisit.images[index]
                homeData.showImageViewer.toggle()
            }
        } label: {
            ZStack{
                Image(currentVisit.images[index])
                    .resizable()
                    .scaledToFill()
                    .frame(width: (GetRect().width - 40) / 2, height: 120)
                    .cornerRadius(12)
            }
        }

    }
}

struct GridImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - extending view to get screen size
extension View{
    func GetRect() -> CGRect{
        return UIScreen.main.bounds
    }
}
