//
//  FavoritesView.swift
//  myApp
//
//  Created by AntoineBendafi on 21/11/2023.
//

import SwiftUI

struct FavoritesView: View {
    // Accès aux données des images partagées dans toute l'application.
    //Transmettre cette source de vérité
    @EnvironmentObject var imageDataManager: ImageDataManager

    var body: some View {
        NavigationView {
            List {
                ForEach(imageDataManager.images.filter { $0.isFavorite }, id: \.id) { imageData in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: imageData.url)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                        .clipped()

                        Text(imageData.title)
                            .font(.headline)

                        Text("de \(imageData.author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text(imageData.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Favoris")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(ImageDataManager())
    }
}





