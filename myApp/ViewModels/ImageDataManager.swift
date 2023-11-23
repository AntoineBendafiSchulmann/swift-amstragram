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

    func addImage(_ imageData: ImageData) {
        images.append(imageData)
        authors.insert(imageData.author)
        saveImages()
    }

    func removeImage(byId id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            authors.remove(images[index].author)
            images.remove(at: index)
            saveImages()
        }
    }

    func updateImage(_ updatedImageData: ImageData) {
        if let index = images.firstIndex(where: { $0.id == updatedImageData.id }) {
            images[index] = updatedImageData
            saveImages()
        }
    }
    

    func toggleFavorite(for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].isFavorite.toggle()
            objectWillChange.send()
            saveImages()
        }
    }

    private func saveImages() {
        do {
            let data = try JSONEncoder().encode(images)
            let url = getDocumentsDirectory().appendingPathComponent("images.json")
            try data.write(to: url)
        } catch {
            print("Erreur lors de la sauvegarde des images: \(error)")
        }
    }

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

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

















