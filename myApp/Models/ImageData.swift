//
//  ImageData.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import Foundation

class ImageData: Codable, Identifiable, ObservableObject {
    //Codable est un protocole en Swift qui permet de simplifier le processus de conversion des données entre les formats structurés (comme ici JSON) et les types personnalisés en Swift.
    // Lorsqu'une classe ou une structure conforme à Codable, elle peut automatiquement encoder ses propriétés en JSON (ou autre format) et peut également être initialisée à partir de données JSON.
    //Codable est particulièrement utile pour lire et écrire des données sur le disque ou pour communiquer avec des APIs web qui renvoient ou acceptent seulement des données JSON
    
    let id: UUID // Identifiant unique pour chaque instance d'image. Utilisé pour distinguer les images.
    
    // Les propriétés annotées avec `@Published` déclencheront des mises à jour de l'interface utilisateur
    // dans SwiftUI lorsqu'elles sont modifiées.
    @Published var url: String
    @Published var title: String
    @Published var description: String
    @Published var author: String
    @Published var date: Date
    @Published var isFavorite: Bool

    // `CodingKeys` définit les clés utilisées pour encoder et décoder les instances de cette classe.
    // Cela permet de mapper les noms des propriétés sur les clés utilisées dans le fichier JSON.
    enum CodingKeys: String, CodingKey {
        case id, url, title, description, author, date, isFavorite
    }

    // Initialisateur pour créer une nouvelle instance avec toutes les propriétés nécessaires.
    init(url: String, title: String, description: String, author: String, date: Date, isFavorite: Bool = false) {
        self.id = UUID()
        self.url = url
        self.title = title
        self.description = description
        self.author = author
        self.date = date
        self.isFavorite = isFavorite
    }
    
    // Initialisateur requis pour `Decodable`.
    // Utilisé pour créer une instance à partir des données décodées (par exemple, comme ici lors du chargement du fichier JSON).
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        author = try container.decode(String.self, forKey: .author)
        date = try container.decode(Date.self, forKey: .date)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    // Méthode requise pour `Encodable`.
    // Utilisée pour encoder l'instance en données (par exemple, comme ici pour la sauvegarde dans un fichier JSON).
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(author, forKey: .author)
        try container.encode(date, forKey: .date)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}




















