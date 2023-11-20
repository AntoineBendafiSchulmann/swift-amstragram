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
    // Accès aux données des images partagées dans toute l'application.
    @EnvironmentObject var imageDataManager: ImageDataManager
    // Utilisé pour fermer la vue actuelle.
    @Environment(\.presentationMode) var presentationMode

    init(imageData: ImageData) {
        _imageData = State(initialValue: imageData)
    }

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
                    // Bouton Modifier
                    Button(action: { isEditing = true }) {
                        Label("Modifier", systemImage: "pencil")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    // Bouton Supprimer
                    Button(action: {
                        imageDataManager.removeImage(byUrl: imageData.url)
                        presentationMode.wrappedValue.dismiss()
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
                EditImageView(imageData: $imageData)
                    .environmentObject(imageDataManager)
            }
        }
        .navigationBarTitle("Détails de l'Image", displayMode: .inline)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageData: ImageData(url: "https://example.com/image.jpg", title: "titre", description: "description", author: "Antoine", date: Date()))
            .environmentObject(ImageDataManager())
    }
}




