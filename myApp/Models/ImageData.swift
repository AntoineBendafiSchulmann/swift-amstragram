//
//  ImageData.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import Foundation

// rendre l'objet observable: permet à SwiftUI de surveiller les changements dans les données qu'elle gère
class ImageData: ObservableObject, Identifiable {
    let id: UUID
    @Published var url: String
    @Published var title: String
    @Published var description: String
    @Published var author: String
    @Published var date: Date
    @Published var isFavorite: Bool

    init(url: String, title: String, description: String, author: String, date: Date, isFavorite: Bool = false) {
        self.id = UUID()
        self.url = url
        self.title = title
        self.description = description
        self.author = author
        self.date = date
        self.isFavorite = isFavorite
    }
}








