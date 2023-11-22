//
//  ContentView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    //Transmettre cette source de vérité
    @EnvironmentObject var imageDataManager: ImageDataManager

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    ForEach(imageDataManager.images, id: \.id) { imageData in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: ImageView(imageData: imageData)) {
                                AsyncImage(url: URL(string: imageData.url)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 20)
                                .clipped()
                            }

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(imageData.title)
                                        .font(.headline)
                                        .padding([.top, .horizontal])

                                    Text("de \(imageData.author)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal)
                                    

                                }

                                Spacer()

                                // Bouton pour basculer l'état favori
                                Button(action: {
                                    imageDataManager.toggleFavorite(for: imageData.id)
                                }) {
                                    Image(systemName: imageData.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(imageData.isFavorite ? .red : .gray)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
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





























