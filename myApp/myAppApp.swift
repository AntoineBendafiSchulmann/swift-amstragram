//
//  myAppApp.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

@main
struct myAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView().environmentObject(ImageDataManager())
        }
    }
}
