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
        // Création d'une liste initiale d'images pour aller plus vite en testant
        let initialImages = [
            ImageData(url: "https://uploads-ssl.webflow.com/5f3c19f18169b62a0d0bf387/60d33be745999ac3353f49bd_KyhyHs_Rlf3kWWoC8Al_C9Y9SZ4dQu_K0fiLIsiCA5Gl8M3Eq77np68PFUgDPd6lKA8EmhKgWs7joHpsQm8upaoIayr4hi6O7Oj3HTzcoVop1HORjy74OdVTZNqFg_mIlfotr0EJ.png", title: "Image 1", description: "Description 1", author: "Auteur 1", date: Date()),
            ImageData(url: "https://www.freecodecamp.org/news/content/images/2019/07/arrays-are-objects.jpg", title: "Image 2", description: "Description 2", author: "Auteur 2", date: Date()),
            // Plus d'images ici...
        ]
        self.images = initialImages

        // Création d'une liste d'auteurs liés aux images crées ci-dessus
        self.authors = Set(initialImages.map { $0.author })
    }

    // Ajoute une nouvelle image à la collection et met à jour la liste des auteurs
    func addImage(_ imageData: ImageData) {
        images.append(imageData)
        authors.insert(imageData.author)
    }
    // Supprime une image par URL et met à jour la liste des auteurs si nécessaire
    func removeImage(byUrl url: String) {
        if let index = images.firstIndex(where: { $0.url == url }) {
            authors.remove(images[index].author)
            images.remove(at: index)
        }
    }
    // Met à jour une image existante
    func updateImage(_ updatedImageData: ImageData) {
        if let index = images.firstIndex(where: { $0.url == updatedImageData.url }) {
            images[index] = updatedImageData
        }
    }
}



