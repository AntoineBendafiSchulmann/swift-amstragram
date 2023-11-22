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

    // Ces variables temporaires sont nécessaires pour stocker les changements avant de les appliquer
    @State private var tempUrl: String
    @State private var tempTitle: String
    @State private var tempDescription: String
    @State private var tempAuthor: String

    init(imageData: Binding<ImageData>, authors: Set<String>) {
        self._imageData = imageData
        self.authors = authors
        _tempUrl = State(initialValue: imageData.wrappedValue.url)
        _tempTitle = State(initialValue: imageData.wrappedValue.title)
        _tempDescription = State(initialValue: imageData.wrappedValue.description)
        _tempAuthor = State(initialValue: imageData.wrappedValue.author)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image URL")) {
                    TextField("Image URL", text: $tempUrl)
                }

                Section(header: Text("Détails")) {
                    TextField("Title", text: $tempTitle)
                    TextField("Description", text: $tempDescription)
                    Picker("Author", selection: $tempAuthor) {
                        ForEach(Array(authors), id: \.self) { author in
                            Text(author).tag(author)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Button("Sauvegarder les modifications") {
                    imageData.url = tempUrl
                    imageData.title = tempTitle
                    imageData.description = tempDescription
                    imageData.author = tempAuthor
                    imageDataManager.updateImage(imageData)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Modifier l'Image", displayMode: .inline)
        }
    }
}

// Ajustez les données initiales pour la prévisualisation
struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        let authors = ["Auteur 1", "Auteur 2", "Auteur 3"]
        let imageData = Binding.constant(ImageData(url: "https://example.com/image.jpg", title: "titre", description: "description", author: "Antoine", date: Date()))
        return EditImageView(imageData: imageData, authors: Set(authors))
            .environmentObject(ImageDataManager())
    }
}
















