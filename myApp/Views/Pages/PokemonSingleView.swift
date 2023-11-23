//
//  PokemonSingleView.swift
//  myApp
//
//  Created by AntoineBendafi on 22/11/2023.
//

import SwiftUI

struct PokemonSingleView: View {
    @EnvironmentObject var viewModel: PokemonDataManager
    let pokemon: PokemonData

    var body: some View {
        ScrollView {
            VStack {
                // Affichage de l'image du Pokémon.
                if let url = URL(string: pokemon.sprites.front_default) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                }
                
                // Affichage des types du Pokémon avec couleur adaptée.
                HStack {
                   ForEach(pokemon.types, id: \.slot) { typeEntry in
                      Text(typeEntry.type.name.capitalized)
                        .padding(5)
                       // Utilisation de l'extension
                        .background(typeEntry.type.name.pokemonTypeColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }

                // Nom du Pokémon.
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .padding(.top)

                // Bouton pour jouer le cri du Pokémon.
                Button(action: {
                    viewModel.playPokemonCry(for: pokemon.id)
                }) {
                    Text("Jouer Cri")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }

                // Affichage des statistiques du Pokémon
                ForEach(pokemon.stats, id: \.stat.name) { stat in
                    HStack {
                        // Nom de la statistique
                        Text(stat.stat.name.capitalized)
                            .frame(width: 100, alignment: .leading)
                        // Jauge de la statistique.
                        ProgressView(value: Double(stat.base_stat), total: 255)
                            .progressViewStyle(LinearProgressViewStyle())
                            .frame(width: 200, height: 20)
                    }
                }
            }
            .padding()
            .navigationBarTitle(pokemon.name.capitalized, displayMode: .inline)
        }
    }
}

struct PokemonSingleView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyTypes = [PokemonTypeEntry(slot: 1, type: TypeDetail(name: "grass")), PokemonTypeEntry(slot: 2, type: TypeDetail(name: "poison"))]
        let dummyPokemon = PokemonData(id: 1,
                                       name: "bulbasaur",
                                       sprites: PokemonSprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
                                       types: dummyTypes,
                                       stats: [PokemonStat(base_stat: 45, stat: StatDetail(name: "hp")),
                                               PokemonStat(base_stat: 49, stat: StatDetail(name: "attack"))])
        return PokemonSingleView(pokemon: dummyPokemon).environmentObject(PokemonDataManager())
    }
}













