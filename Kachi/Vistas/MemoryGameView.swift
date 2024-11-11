import SwiftUI
import Combine

struct MemoryGameView: View {
    @State private var cards: [MemoryCard] = [
        MemoryCard(content: .text("Atl")),
        MemoryCard(content: .text("🌊")),
        MemoryCard(content: .text("Tonalli")),
        MemoryCard(content: .text("☀️")),
        MemoryCard(content: .text("Metztli")),
        MemoryCard(content: .text("🌙")),
        MemoryCard(content: .text("Ehecatl")),
        MemoryCard(content: .text("🌬️"))
    ].shuffled()

    @State private var indexOfSelectedCard: Int? = nil
    @State private var isProcessing: Bool = false
    @State private var timeRemaining: Double = 10.0
    @State private var totalTime: Double = 10.0
    @State private var timerActive: Bool = false // Timer inicialmente inactivo
    @State private var isGameOver: Bool = false
    @State private var isWin: Bool = false
    @State private var timer: AnyCancellable?
    @State private var showRulesModal: Bool = true // Mostrar reglas al principio
    @State private var showWinModal: Bool = false // Modal de ganar
    @State private var showGameOverModal: Bool = false // Modal de perder

    @Environment(\.presentationMode) var presentationMode

    let matchingPairs: [String: String] = [
        "Atl": "🌊",
        "Tonalli": "☀️",
        "Metztli": "🌙",
        "Ehecatl": "🌬️"
    ]

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack {
                ProgressBar(progress: CGFloat(timeRemaining / totalTime), animationDuration: 0.05)
                    .frame(height: 20)
                    .padding()
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cards.indices, id: \.self) { index in
                        Card(card: cards[index])
                            .onTapGesture {
                                handleCardTap(at: index)
                            }
                    }
                }
                .padding()
                
                Spacer()
            }
            .onDisappear {
                timer?.cancel()
            }
            .sheet(isPresented: $showRulesModal, content: {
                GameRulesView(timeLimit: totalTime) {
                    showRulesModal = false
                    startTimer()
                }
            })
            .sheet(isPresented: $showWinModal, content: {
                WinView(onPlayAgain: resetGame, onReturnToHome: returnToHome)
            })
            .sheet(isPresented: $showGameOverModal, content: {
                GameOverView(onRetry: resetGame, onReturnToHome: returnToHome)
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }

    func handleCardTap(at index: Int) {
        if isProcessing || cards[index].isFaceUp || cards[index].isMatched { return }

        cards[index].isFaceUp = true
        
        if let selectedIndex = indexOfSelectedCard {
            isProcessing = true

            if isMatch(card1: cards[selectedIndex], card2: cards[index]) {
                cards[selectedIndex].isMatched = true
                cards[index].isMatched = true
                resetTimer()

                if checkForWin() {
                    showWinModal = true
                }

            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cards[selectedIndex].isFaceUp = false
                    cards[index].isFaceUp = false
                }
            }
            indexOfSelectedCard = nil
            isProcessing = false
        } else {
            indexOfSelectedCard = index
        }
    }

    func checkForWin() -> Bool {
        return cards.allSatisfy { $0.isMatched }
    }

    func isMatch(card1: MemoryCard, card2: MemoryCard) -> Bool {
        if case let .text(content1) = card1.content, case let .text(content2) = card2.content {
            return matchingPairs[content1] == content2 || matchingPairs[content2] == content1
        }
        return false
    }

    func startTimer() {
        timerActive = true
        timer = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timerActive {
                    if timeRemaining > 0 {
                        withAnimation(.linear(duration: 0.05)) {
                            timeRemaining -= 0.05
                        }
                    } else {
                        timer?.cancel()
                        timerActive = false
                        showGameOverModal = true
                    }
                }
            }
    }

    func resetTimer() {
        withAnimation(.linear(duration: 0.5)) {
            timeRemaining = totalTime
        }
        timerActive = true
    }

    func resetGame() {
        timeRemaining = totalTime
        cards = cards.map { card in
            var newCard = card
            newCard.isFaceUp = false
            newCard.isMatched = false
            return newCard
        }.shuffled()
        
        isGameOver = false
        isWin = false
        showWinModal = false
        showGameOverModal = false
        showRulesModal = true
        indexOfSelectedCard = nil
        timer?.cancel()
    }

    func returnToHome() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct GameRulesView: View {
    let timeLimit: Double
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("line")
                .resizable()
                .scaledToFit()
            
            Text("Reglas del Juego")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(Color.azulMexicano)
                .foregroundColor(.white)
                .padding(.vertical, 20)
            
            VStack {
                
                Text("Empareja todas las cartas antes de que el tiempo se acabe.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                Text("Tienes \(Int(timeLimit)) segundos para completar el juego.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                Button(action: onDismiss) {
                    Text("¡Entendido!")
                        .font(.headline)
                        .padding()
                        .background(Color.rosaMexicano)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }.padding(.horizontal)
            
            Image("line")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(180))
        }
    }
}

#Preview {
    MemoryGameView()
}
