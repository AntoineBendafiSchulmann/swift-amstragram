//
//  ContentView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var imageDataManager: ImageDataManager

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    ForEach(imageDataManager.images.indices, id: \.self) { index in
                        NavigationLink(destination: ImageView(imageData: imageDataManager.images[index])) {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: imageDataManager.images[index].url)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 20)
                                .clipped()

                                Text(imageDataManager.images[index].title)
                                    .font(.headline)
                                    .padding([.top, .horizontal])

                                Text("de \(imageDataManager.images[index].author)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                            }
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                            .padding(.vertical, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // on importe la sorte de header
                    LogoBarView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ImageDataManager())
    }
}






