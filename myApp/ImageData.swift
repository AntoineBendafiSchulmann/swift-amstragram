//
//  ImageData.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import Foundation

class ImageData: ObservableObject, Identifiable {
    @Published var url: String
    @Published var title: String
    @Published var description: String
    @Published var author: String
    @Published var date: Date

    init(url: String, title: String, description: String, author: String, date: Date) {
        self.url = url
        self.title = title
        self.description = description
        self.author = author
        self.date = date
    }
}

