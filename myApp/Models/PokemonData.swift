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

// Structure pour le type de Pokémon.
struct PokemonTypeEntry: Decodable {
    let slot: Int
    let type: TypeDetail
}

// Détail du type de Pokémon.
struct TypeDetail: Decodable {
    let name: String
}

// Les données principales de chaque Pokémon, y compris les types.
struct PokemonData: Decodable, Identifiable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonTypeEntry]
    let stats: [PokemonStat]
}

// Sprites (images) du Pokémon.
struct PokemonSprites: Decodable {
    let front_default: String
}









