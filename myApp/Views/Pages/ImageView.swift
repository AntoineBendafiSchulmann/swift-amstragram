//
//  ImageView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct ImageView: View {
    @State private var imageData: ImageData
    @State private var isEditing = false
    // on créé la variable d'état pour la popup
    @State private var showingDeleteAlert = false

    // Accès aux données des images partagées dans toute l'application.
    //Transmettre cette source de vérité
    @EnvironmentObject var imageDataManager: ImageDataManager
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode

    init(imageData: ImageData) {
        _imageData = State(initialValue: imageData)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Affichage de l'image
                AsyncImage(url: URL(string: imageData.url)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)

                // Titre et description de l'image
                Text(imageData.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(imageData.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                // Auteur et date
                HStack {
                    Text("de " + imageData.author)
                    Spacer()
                    Text(formatDate(imageData.date))
                }
                .font(.caption)
                .foregroundColor(.gray)

                // Boutons Modifier et Supprimer
                HStack {
                    Button(action: { isEditing = true }) {
                        Label("Modifier", systemImage: "pencil")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        Label("Supprimer", systemImage: "trash")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
            .sheet(isPresented: $isEditing) {
                        EditImageView(imageData: $imageData, authors: imageDataManager.authors)
                            .environmentObject(imageDataManager)
            }
        }
        .navigationBarTitle("Détails de l'image", displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Confirmer la suppression"),
                message: Text("Voulez-vous vraiment supprimer cette image ?"),
                primaryButton: .destructive(Text("Supprimer")) {
                    imageDataManager.removeImage(byUrl: imageData.url)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }

    // Fonction pour formater la date
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageData: ImageData(url: "https://example.com/image.jpg", title: "titre", description: "description", author: "Antoine", date: Date()))
            .environmentObject(ImageDataManager())
    }
}




