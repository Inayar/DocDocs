//
//  Home.swift
//  DocDocs2
//
//  Created by Евгений Солохин on 29.05.2023.
//

import SwiftUI

struct Home: View {
    
//    let docVisits: [DocVisitModel] = [
//    DocVisitModel(docName: "Irina Popova", date: "11.04.2023", images: ["1", "2"]),
//    DocVisitModel(docName: "Maria Petrova", date: "22.05.2023", images: ["3", "4"])
//    ]
    
    @StateObject var homeData = TreViewModel()
    // инициализация синглтона
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(homeData.visits){visit in
                    // для каждой записи визита - тип данных DocVisitModel
                    NavigationLink {
                        TreView(visit: visit)
                        // передаем DocVisitModel(docName: "Irina Popova", date: "11.04.2023", images: ["1", "2"]),
                        
                    } label: {
                        HStack{
                            Text(visit.docName)
                            Spacer()
                            Text(visit.date)
                        }
                    }
                }
            }
            
            .listStyle(.inset)
            .navigationTitle("Картотека")
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .tint(.black)
        }
        // setting environment object
        .environmentObject(homeData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
