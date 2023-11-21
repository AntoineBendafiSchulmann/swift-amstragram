//
//  myAppApp.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

@main
struct myAppApp: App {
    // Créer une source de vérité
    // Ici, nous déclarons l'objet ImageDataManager en tant que StateObject.
    // Cela crée une instance unique (source de vérité) de ImageDataManager
    // qui survit pendant tout le cycle de vie de l'application.
    @StateObject var imageDataManager = ImageDataManager()

    var body: some Scene {
        WindowGroup {
            // Transmettre cette source de vérité
            // L'objet ImageDataManager est passé aux vues en tant qu'EnvironmentObject.
            // Cela permet à toutes les vues enfants dans la hiérarchie d'accéder à cet objet.
            TabBarView().environmentObject(imageDataManager)
        }
    }
}

