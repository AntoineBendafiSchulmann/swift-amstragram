//
//  EditImageView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct EditImageView: View {
    @Binding var imageData: ImageData
    let authors: Set<String>

    // Accès aux données des images partagées dans toute l'application.
    //Transmettre cette source de vérité
    @EnvironmentObject var imageDataManager: ImageDataManager
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode
    @State private var tempUrl: String
    @State private var previewUrl: String

    init(imageData: Binding<ImageData>, authors: Set<String>) {
        self._imageData = imageData
        self.authors = authors
        // Initialisation des URLs pour la prévisualisation et l'édition
        self._tempUrl = State(initialValue: imageData.wrappedValue.url)
        self._previewUrl = State(initialValue: imageData.wrappedValue.url)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image URL")) {
                    TextField("Image URL", text: $tempUrl)
                        .onChange(of: tempUrl) { newValue in
                            // Mise à jour de l'URL pour la prévisualisation
                            previewUrl = newValue
                        }

                    // Prévisualisation de l'image
                    if let url = URL(string: previewUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }

                Section(header: Text("Détails")) {
                    TextField("Title", text: $imageData.title)

                    Picker("Author", selection: $imageData.author) {
                        ForEach(Array(authors), id: \.self) { author in
                            Text(author).tag(author)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Button("Sauvegarder les modifications") {
                    // Mettre à jour l'URL réelle avant de sauvegarder
                    imageData.url = tempUrl
                    imageDataManager.updateImage(imageData)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Modifier l'Image", displayMode: .inline)
        }
    }
}

struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditImageView(imageData: .constant(ImageData(url: "https://example.com/image.jpg", title: "titre", description: "description", author: "Antoine", date: Date())), authors: ["Antoine", "Auteur 2", "Auteur 3"])
            .environmentObject(ImageDataManager())
    }
}






