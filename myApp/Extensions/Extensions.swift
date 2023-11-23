//
//  Extensions.swift
//  myApp
//
//  Created by AntoineBendafi on 22/11/2023.
//

import SwiftUI

//les extensions permettent d'ajouter des méthodes à des classes déjà existantes , pour ajouter des choses pour lesquelles elles n'étaient pas faites pour.
extension String {
    var pokemonTypeColor: Color {
        switch self.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "ice": return .cyan
        case "rock": return .brown
        case "flying": return Color(UIColor.systemTeal)
        case "psychic": return Color(UIColor.systemPurple)
        case "bug": return Color(UIColor.systemGreen)
        case "poison": return Color(UIColor.systemIndigo)
        case "ground": return Color(UIColor.systemOrange)
        case "fairy": return Color(UIColor.systemPink)
        case "fighting": return Color(UIColor.systemRed)
        case "steel": return Color(UIColor.systemGray)
        case "ghost": return Color(UIColor.systemPurple)
        case "dark": return Color.black
        case "dragon": return Color(UIColor.systemBlue)
        case "normal": return Color(UIColor.systemGray4)
        // Ajoutez d'autres cas si nécessaire
        default: return .gray
        }
    }
}


