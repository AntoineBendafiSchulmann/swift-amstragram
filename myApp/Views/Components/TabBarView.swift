//
//  TabBarView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        ZStack {
            // La vue change en fonction de l'onglet sélectionné
            if selectedTab == 2 {
                AnimationsView(selectedTab: $selectedTab)
            } else {
                standardTabView
            }

            // Bouton flottant au centre
            floatingActionButton
        }
    }

    var standardTabView: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Label("Mon Feed", systemImage: "photo.fill.on.rectangle.fill")
                }
                .tag(0)
            
            PublishView()
                .tabItem {
                    Label("Publier", systemImage: "square.and.pencil")
                }
                .tag(1)

            Color.clear
                .tabItem { EmptyView() }
                .tag(2)

            SearchView()
                .tabItem {
                    Label("Recherche", systemImage: "magnifyingglass")
                }
                .tag(3)

            FavoritesView()
                .tabItem {
                    Label("Favoris", systemImage: "heart.fill")
                }
                .tag(4)
            
            PokemonView()
                .tabItem {
                    Label("Pokedex", systemImage: "list.dash")
                }
                .tag(5)
        }
    }

    // Bouton flottant personnalisé
    var floatingActionButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        // Basculer entre ContentView et AnimationsView
                        selectedTab = selectedTab == 2 ? 0 : 2
                    }
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y: -20) // Légèrement décalé vers le haut
                        .rotationEffect(.degrees(selectedTab == 2 ? 45 : 0))
                }
                Spacer()
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(ImageDataManager())
    }
}




