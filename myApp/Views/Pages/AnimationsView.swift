//
//  AnimationsView.swift
//  myApp
//
//  Created by AntoineBendafi on 23/11/2023.
//

import SwiftUI

struct AnimationsView: View {
    // Liaison à l'onglet sélectionné dans TabBarView
    @Binding var selectedTab: Int

    // États pour gérer les cartes retournées, les paires trouvées, et le démarrage/fin du jeu
    @State private var flippedCards: Set<Int> = []
    @State private var matchedPairs: Set<Int> = []
    @State private var symbols = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌"]
    @State private var shuffledSymbols: [String] = []
    @State private var gameStarted: Bool = false
    @State private var gameWon: Bool = false
    @State private var lastSelectedIndex: Int?

    // Configuration des colonnes pour la grille de cartes
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        ZStack {
            // Fond de l'écran
            Color(hex: "#083b32").edgesIgnoringSafeArea(.all)

            // Affichage de l'écran de victoire ou du jeu
            if gameWon {
                victoryScreen
            } else {
                gameView
            }
        }
        .onAppear(perform: setupGame)
    }

    // Vue principale du jeu
    var gameView: some View {
        VStack {
            if gameStarted {
                // Grille de cartes
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<12, id: \.self) { index in
                        CardView(symbol: shuffledSymbols[index], isFlipped: flippedCards.contains(index) || matchedPairs.contains(index))
                            .onTapGesture {
                                flipCard(at: index)
                            }
                            .padding(10)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: flippedCards)
                    }
                }
                .padding()
            } else {
                // Bouton pour commencer le jeu
                startGameButton
            }
        }
    }

    // Écran de victoire affiché à la fin du jeu
    var victoryScreen: some View {
        VStack {
            Text("Félicitations !")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("Vous avez trouvé toutes les paires.")
                .font(.title)
                .foregroundColor(.yellow)
            Button("Rejouer") {
                resetGame()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .shadow(radius: 5)
        }
    }

    // Bouton pour commencer le jeu
    var startGameButton: some View {
        Button(action: startGame) {
            Text("Commencer le jeu")
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }

    // Initialisation du jeu
    func setupGame() {
        shuffledSymbols = (symbols + symbols).shuffled()
        gameWon = false
        matchedPairs = []
        flippedCards = []
        lastSelectedIndex = nil
    }

    // Commencer le jeu
    func startGame() {
        gameStarted = true
    }

    // Logique pour retourner une carte
    func flipCard(at index: Int) {
        // Ne rien faire si la carte a déjà été appariée
        if matchedPairs.contains(index) {
            return
        }

        // Retourner la carte
        flippedCards.insert(index)
        // Vérifier si deux cartes retournées sont une paire
        if let lastSelectedIndex = lastSelectedIndex, lastSelectedIndex != index {
            if shuffledSymbols[index] == shuffledSymbols[lastSelectedIndex] {
                // Paire trouvée
                matchedPairs.insert(index)
                matchedPairs.insert(lastSelectedIndex)
                self.lastSelectedIndex = nil
                if matchedPairs.count == shuffledSymbols.count {
                    gameWon = true
                }
            } else {
                // Pas une paire, retourner les cartes
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    withAnimation {
                        flippedCards.remove(index)
                        flippedCards.remove(lastSelectedIndex)
                    }
                }
                self.lastSelectedIndex = nil
            }
        } else {
            lastSelectedIndex = index
        }
    }

    // Réinitialiser le jeu
    func resetGame() {
        withAnimation {
            setupGame()
            startGame()
        }
    }
}

// Vue pour chaque carte
struct CardView: View {
    var symbol: String
    var isFlipped: Bool

    var body: some View {
        ZStack {
            if isFlipped {
                // Face de la carte (avec symbole)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .overlay(Text(symbol).font(.largeTitle))
            } else {
                // Dos de la carte (damier)
                CheckerboardPattern()
            }
        }
        .frame(height: 100)
        .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
    }
}

// Damier pour le dos des cartes
struct CheckerboardPattern: View {
    var body: some View {
        GeometryReader { geometry in
            // Création du motif en damier
            let size = geometry.size
            let squareSize = size.width / 8
            Path { path in
                for row in 0..<8 {
                    for col in 0..<8 {
                        if (row + col).isMultiple(of: 2) {
                            path.addRect(CGRect(x: CGFloat(col) * squareSize, y: CGFloat(row) * squareSize, width: squareSize, height: squareSize))
                        }
                    }
                }
            }.fill(Color.red)
            Path { path in
                for row in 0..<8 {
                    for col in 0..<8 {
                        if !(row + col).isMultiple(of: 2) {
                            path.addRect(CGRect(x: CGFloat(col) * squareSize, y: CGFloat(row) * squareSize, width: squareSize, height: squareSize))
                        }
                    }
                }
            }.fill(Color.white)
        }
    }
}



struct AnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView(selectedTab: .constant(2))
    }
}















