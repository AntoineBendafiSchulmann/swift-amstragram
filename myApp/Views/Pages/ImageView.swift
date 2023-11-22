//
//  ImageView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageData: ImageData
    // Accès aux données des images partagées dans toute l'application.
    //Transmettre cette source de vérité
    @EnvironmentObject var imageDataManager: ImageDataManager
    @State private var isEditing = false
    // on créé la variable d'état pour la popup
    @State private var showingDeleteAlert = false
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: imageData.url)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)

                Text(imageData.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(imageData.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                HStack {
                    Text("de " + imageData.author)
                    Spacer()
                    Text(formatDate(imageData.date))
                }
                .font(.caption)
                .foregroundColor(.gray)

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
                if let index = imageDataManager.images.firstIndex(where: { $0.id == imageData.id }) {
                    EditImageView(imageData: $imageDataManager.images[index], authors: imageDataManager.authors)
                        .environmentObject(imageDataManager)
                }
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Confirmer la suppression"),
                    message: Text("Voulez-vous vraiment supprimer cette image ?"),
                    primaryButton: .destructive(Text("Supprimer")) {
                        imageDataManager.removeImage(byId: imageData.id)
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationBarTitle("Détails de l'Image", displayMode: .inline)
    }

    // Fonction pour formater la date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none //on enlève l'heure
        return formatter.string(from: date)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        let imageData = ImageData(url: "https://example.com/image.jpg", title: "Titre Exemple", description: "Description Exemple", author: "Auteur Exemple", date: Date())
        return ImageView(imageData: imageData)
            .environmentObject(ImageDataManager())
    }
}







