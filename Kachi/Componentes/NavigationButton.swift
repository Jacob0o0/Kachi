import SwiftUI

struct NavigationButton<Destination: View>: View {
    var buttonText: String
    var destinationView: Destination
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            Text(buttonText)
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.amarilloMexicano)
                .foregroundColor(.white)
                .cornerRadius(10)
                .bold()
                
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationButton(buttonText: "Navegar a", destinationView: MemoryGameView())
}
