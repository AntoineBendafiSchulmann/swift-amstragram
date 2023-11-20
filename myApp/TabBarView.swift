//
//  TabBarView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Mon Feed", systemImage: "photo.fill.on.rectangle.fill")
                }
            PublishView()
                .tabItem {
                    Label("Publier", systemImage: "star")
                }
            SearchView()
                .tabItem {
                    Label("Recherche", systemImage: "magnifyingglass")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(ImageDataManager())
    }
}

