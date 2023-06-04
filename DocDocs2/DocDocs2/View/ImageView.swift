//
//  ImageView.swift
//  DocDocs2
//
//  Created by Евгений Солохин on 31.05.2023.
//

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var homeData: TreViewModel
    @GestureState var draggingOffset: CGSize = .zero
    var currentVisit: DocVisitModel
    
    var body: some View {
        ZStack{
            
            // tab view has a problem in ignoring edges
            ScrollView(.init()){
                TabView(selection: $homeData.selectedImageID) {
                    ForEach(currentVisit.images, id: \.self){ image in
                        
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .tag(image)
                            .scaleEffect(homeData.selectedImageID == image ? (homeData.imageScale > 1 ? homeData.imageScale : 1) : 1)
                        // moving only image for smooth animation
                            .offset(y: homeData.imageViewerOffset.height)
                            .gesture(
                            // magnifying gesture
                                MagnificationGesture().onChanged({ value in
                                    homeData.imageScale = value
                                }).onEnded({ _ in
                                    withAnimation(.spring()) {
                                        homeData.imageScale = 1
                                    }
                                })
                                
                                // double to zoom
                                    .simultaneously(with: TapGesture(count: 2).onEnded({ value in
                                        withAnimation {
                                            homeData.imageScale = homeData.imageScale > 1 ? 1 : 4
                                        }
                                    }))
                            )
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .overlay(
                    // close button
                    Button {
                        withAnimation(.default) {
                            // removing defalt
                            homeData.showImageViewer.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.white.opacity(0.35))
                            .clipShape(Circle())
                    }
                    .padding(10)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .opacity(homeData.bgOpacity)
                    ,alignment: .topTrailing
                )
            }
            .ignoresSafeArea()
            
        }
        .gesture(DragGesture().updating($draggingOffset, body: { value, outValue, _ in
            outValue = value.translation
            homeData.onChange(value: draggingOffset)
        }).onEnded({ value in
            homeData.onEnd(value: value)
        }))
        .transition(.move(edge: .bottom))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
