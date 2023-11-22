//
//  PokemonData.swift
//  myApp
//
//  Created by AntoineBendafi on 22/11/2023.
//

import Foundation

// Liste des Pokémon renvoyée par l'API.
struct PokemonList: Decodable {
    let results: [PokemonEntry]
}

// Entrée individuelle pour chaque Pokémon dans la liste.
struct PokemonEntry: Decodable {
    let name: String
    let url: String
}
// Statistiques détaillées de chaque Pokémon.
struct PokemonStat: Decodable {
    let base_stat: Int
    let stat: StatDetail
}

// Détail de chaque stat (comme 'hp', 'attack', etc.).
struct StatDetail: Decodable {
    let name: String
}

// Informations détaillées sur chaque Pokémon.
struct PokemonData: Decodable, Identifiable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let stats: [PokemonStat]
}

// Sprites (images) du Pokémon.
struct PokemonSprites: Decodable {
    let front_default: String
}









