import SwiftUI

struct MemoryCard: Identifiable {
    let id = UUID()
    let content: CardContent
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

enum CardContent: Equatable {
    case text(String)
    case image(String)
}

struct Card: View {
    var card: MemoryCard

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                
                switch card.content {
                    
                case .text(let text):
                    Text(text)
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                case .image(let imageName):
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            } else {
                // Parte trasera de la carta
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.rosaMexicano)
                
                Image("kachi_blanco")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
        }
        .frame(width: 150, height: 120)
        .clipped()
        .background(card.isMatched ? Color.amarilloMexicano : Color.clear)
        .cornerRadius(10)
    }
}

#Preview {
    let exampleCard = MemoryCard(content: .text("Atl"), isFaceUp: true)
    Card(card: exampleCard)
}
