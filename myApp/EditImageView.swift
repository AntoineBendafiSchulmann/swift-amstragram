//
//  EditImageView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct EditImageView: View {
    @Binding var imageData: ImageData
    // Accès aux données des images partagées dans toute l'application.
    @EnvironmentObject var imageDataManager: ImageDataManager
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Image URL")) {
                TextField("Image URL", text: $imageData.url)

                // Prévisualisation de l'image
                if let url = URL(string: imageData.url), imageData.url != "" {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        // Indicateur de progression affiché pendant le chargement de l'image au cas ou
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                }
            }

            Section(header: Text("Détails")) {
                TextField("Title", text: $imageData.title)
                TextField("Author", text: $imageData.author)
            }

            Button("Sauvegarder les modifications") {
                imageDataManager.updateImage(imageData)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitle("Modifier l'Image", displayMode: .inline)
    }
}

struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditImageView(imageData: .constant(ImageData(url: "https://example.com/image.jpg", title: "titre", description: "description", author: "Antoine", date: Date())))
            .environmentObject(ImageDataManager())
    }
}


