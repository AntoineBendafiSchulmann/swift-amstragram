//
//  ImageDataManager.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import Foundation

class ImageDataManager: ObservableObject {
    @Published var images: [ImageData]
    @Published var authors: Set<String>

    init() {
        self.images = []
        self.authors = []
        loadImages()
    }

    // Ajoute une nouvelle image et sauvegarde la collection.
    func addImage(_ imageData: ImageData) {
        images.append(imageData)
        authors.insert(imageData.author)
        saveImages()
    }

    // Supprime une image et sauvegarde la collection.
    func removeImage(byId id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            authors.remove(images[index].author)
            images.remove(at: index)
            saveImages()
        }
    }

    //met à jour une image et sauvegarde la collection
    func updateImage(_ updatedImageData: ImageData) {
        if let index = images.firstIndex(where: { $0.id == updatedImageData.id }) {
            images[index] = updatedImageData
            saveImages()
        }
    }
    
    // Bascule le statut de favori et sauvegarde immédiatement.
    func toggleFavorite(for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].isFavorite.toggle()
            objectWillChange.send()
            saveImages()
        }
    }

    // Sauvegarde la collection d'images dans un fichier JSON.
    private func saveImages() {
        do {
            let data = try JSONEncoder().encode(images)
            let url = getDocumentsDirectory().appendingPathComponent("images.json")
            try data.write(to: url)
        } catch {
            print("Erreur lors de la sauvegarde des images: \(error)")
        }
    }

    // Charge les images depuis un fichier JSO
    private func loadImages() {
        let url = getDocumentsDirectory().appendingPathComponent("images.json")
        do {
            let data = try Data(contentsOf: url)
            images = try JSONDecoder().decode([ImageData].self, from: data)
            authors = Set(images.map { $0.author })
        } catch {
            print("Erreur lors du chargement des images: \(error)")
        }
    }

    // Renvoie le répertoire des documents de l'application pour le stockage.
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

















