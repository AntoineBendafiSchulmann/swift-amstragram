//
//  PokemonView.swift
//  myApp
//
//  Created by AntoineBendafi on 22/11/2023.
//

import SwiftUI

struct PokemonView: View {
    @StateObject var viewModel = PokemonDataManager()
    @State private var searchText = ""

    // Filtrer les Pokémons en fonction de la recherche.
    var filteredPokemons: [PokemonData] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Champ de recherche pour filtrer les Pokémons.
                TextField("Recherche par nom", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Affichage de la liste scrollable des Pokémons.
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 50) {
                        ForEach(filteredPokemons, id: \.id) { pokemon in
                            // Lien vers les détails de chaque Pokémon.
                            NavigationLink(destination: PokemonSingleView(pokemon: pokemon).environmentObject(viewModel)) {
                                VStack {
                                    // Affichage de l'image du Pokémon
                                    if let url = URL(string: pokemon.sprites.front_default) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(50)
                                    }

                                    // Affichage de l'ID et du nom.
                                    Text("#\(pokemon.id)")
                                        .foregroundColor(.black)
                                        .font(.caption2)
                                    Text(pokemon.name.capitalized)
                                        .foregroundColor(.black)
                                        .font(.caption)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Pokédex")
            .onAppear {
                viewModel.fetchPokemons()
            }
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView().environmentObject(PokemonDataManager())
    }
}














