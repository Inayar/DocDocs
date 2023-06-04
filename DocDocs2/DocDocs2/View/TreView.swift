//
//  3.swift
//  DocDocs2
//
//  Created by Евгений Солохин on 31.05.2023.
//

import ImageViewer
import SwiftUI

struct TreView: View {
    
   // @State var visit: DocVisitModel
    
    @EnvironmentObject var homeData: TreViewModel
    var visit: DocVisitModel // приходит DocVisitModel(docName: "Irina Popova", date: "11.04.2023", images: ["1", "2"]),
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 15) {
                Text("Date: \(visit.date)") // "Irina Popova"
                Text("Doctor: \(visit.docName)") // "11.04.2023"

                
                let collums = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                
                LazyVGrid(columns: collums, alignment: .center, spacing: 10) {
                    ForEach(visit.images.indices, id: \.self){ index in
                        // ["1", "2"]
                        GridImageView(index: index, currentVisit: visit) // передает индекс типа Int 
                    }
                }
                .padding(.top)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .overlay{
            // image viewer
            
            
            ImageViewer(image: Image(self.visit.images[1]), viewerShown: $homeData.showImageViewer)
            
//            ZStack{
//                if homeData.showImageViewer {
//                    Color.black.ignoresSafeArea().opacity(homeData.bgOpacity)
//                    ImageView(currentVisit: visit)
//                }
//            }
        }
        
        
    }
}

struct TreViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
