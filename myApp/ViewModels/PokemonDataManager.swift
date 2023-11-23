//
//  PokemonDataManager.swift
//  myApp
//
//  Created by AntoineBendafi on 22/11/2023.
//

import Foundation
import AVFoundation

// Gère la récupération des données des Pokémon et la lecture des sons.
class PokemonDataManager: ObservableObject {
    @Published var pokemons: [PokemonData] = []
    var player: AVAudioPlayer?

    // Récupère les  Pokémons avec un nombre spécifique.
    func fetchPokemons() {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        guard let url = URL(string: urlString) else { return }

        // Tâche asynchrone pour télécharger les données
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                // Pour chaque Pokémon, récupérer les détails.
                for entry in pokemonList.results {
                    self.fetchPokemonDetails(from: entry.url)
                }
            } catch {
                print("Error decoding list: \(error)")
            }
        }.resume()
    }
    
    // Récupérer les détails de chaque Pokémon par son URL.
    private func fetchPokemonDetails(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let pokemonDetails = try JSONDecoder().decode(PokemonData.self, from: data)
                // Mettre à jour l'état avec les détails du Pokémon.
                DispatchQueue.main.async {
                    self.pokemons.append(pokemonDetails)
                }
            } catch {
                print("Error decoding details: \(error)")
            }
        }.resume()
    }

    // Joue le son du Pokémon spécifique
    func playPokemonCry(for pokemonId: Int) {
        let urlString = "https://pokemoncries.com/cries-old/\(pokemonId).mp3"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Erreur lors du téléchargement du fichier audio: \(error)")
                return
            }

            guard let data = data else {
                print("Aucune donnée reçue pour le fichier audio")
                return
            }

            DispatchQueue.main.async {
                do {
                    //lecture du son.
                    self?.player = try AVAudioPlayer(data: data)
                    self?.player?.play()
                } catch {
                    print("Erreur lors de la lecture du son: \(error)")
                }
            }
        }.resume()
    }
}









