import SwiftUI

struct WinView: View {
    let onPlayAgain: () -> Void
    let onReturnToHome: () -> Void
    
    var body: some View {
        ZStack{
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Image("line")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                ZStack {
                    // Imagen del personaje
                    Image("logo2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 150)
                        .offset(y: -70)
                    
                    Text("¡Ganaste!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.azulMexicano)
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                }
                
                Text("¡Felicidades, emparejaste todas las cartas!")
                    .padding()
                
                Button(action: onPlayAgain) {
                    Text("Jugar de nuevo")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .background(Color.verdeAguaMexicano)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Button(action: onReturnToHome) {
                    Text("Regresar al inicio")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .background(Color.amarilloMexicano)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
                
                Image("line")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(180))
                
            }
            .padding(.vertical, 70)
        }
    }
}

#Preview {
    WinView(onPlayAgain: {}, onReturnToHome: {})
}
