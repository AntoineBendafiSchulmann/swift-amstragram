//
//  SearchView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var imageDataManager: ImageDataManager
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Rechercher par titre", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .autocapitalization(.none)

                if filteredImages.isEmpty && !searchText.isEmpty {
                    // Affiche un message si aucun résultat n'est trouvé
                    Text("Aucun résultat 🥲")
                        .padding()
                } else {
                    List(filteredImages, id: \.url) { imageData in
                        NavigationLink(destination: ImageView(imageData: imageData)) {
                            VStack(alignment: .leading) {
                                Text(imageData.title)
                                    .fontWeight(.bold)
                                Text("de \(imageData.author)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recherche")
        }
    }

    // Filtre les images en fonction du titre
    var filteredImages: [ImageData] {
        if searchText.isEmpty {
            return imageDataManager.images
        } else {
            return imageDataManager.images.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(ImageDataManager())
    }
}

