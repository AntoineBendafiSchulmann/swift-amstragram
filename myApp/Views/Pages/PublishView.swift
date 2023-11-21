//
//  PublishView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct PublishView: View {
    // Accès aux données des images partagées dans toute l'application.
    //Transmettre cette source de vérité
    @EnvironmentObject var imageDataManager: ImageDataManager
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State private var author = ""
    @State private var imageUrl = ""
    @State private var date = Date()
    // on créé la variable d'état pour la popup
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Veuillez renseigner les informations de votre publication")) {
                    TextField("Image URL", text: $imageUrl)

                    if let url = URL(string: imageUrl), imageUrl != "" {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
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
                    title = ""
                    description = ""
                    author = ""
                    imageUrl = ""
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

