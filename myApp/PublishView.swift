//
//  PublishView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct PublishView: View {
    // Accès aux données des images partagées dans toute l'application.
    @EnvironmentObject var imageDataManager: ImageDataManager
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State private var author = ""
    @State private var imageUrl = ""
    @State private var date = Date()
    @State private var showAlert = false // État pour gérer l'affichage de l'alerte

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Veuillez renseigner les informations de votre publication")) {
                    TextField("Image URL", text: $imageUrl)
                    // Vérifie si l'URL entrée est valide et non vide
                    if let url = URL(string: imageUrl), imageUrl != "" {
                        // Utilisation de AsyncImage pour charger et afficher l'image depuis l'URL
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            // Indicateur de progression affiché pendant le chargement de l'image au cas ou
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                    }

                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Description", text: $description)
                }

                Button("Publish") {
                    let newImageData = ImageData(url: imageUrl, title: title, description: description, author: author, date: date)
                    imageDataManager.addImage(newImageData)
                    // Vider les champs
                    title = ""
                    description = ""
                    author = ""
                    imageUrl = ""
                    // Afficher l'alerte de succès
                    showAlert = true
                }
            }
            .navigationBarTitle("Publier une Image")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Succès"),
                    message: Text("Votre image a été publiée avec succès, allez la retrouver dans votre feed !"),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView().environmentObject(ImageDataManager())
    }
}
