//
//  ImageData.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import Foundation

class ImageData: Codable, Identifiable, ObservableObject {
    let id: UUID
    @Published var url: String
    @Published var title: String
    @Published var description: String
    @Published var author: String
    @Published var date: Date
    @Published var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id, url, title, description, author, date, isFavorite
    }

    init(url: String, title: String, description: String, author: String, date: Date, isFavorite: Bool = false) {
        self.id = UUID()
        self.url = url
        self.title = title
        self.description = description
        self.author = author
        self.date = date
        self.isFavorite = isFavorite
    }

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




















