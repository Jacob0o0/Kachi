import SwiftUI

struct GameOverView: View {
    let onRetry: () -> Void
    let onReturnToHome: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Perdiste!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Se acabó el tiempo. ¿Quieres intentarlo de nuevo?")

            Button(action: onRetry) {
                Text("Intentar de nuevo")
                    .font(.headline)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: onReturnToHome) {
                Text("Regresar al inicio")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    GameOverView(onRetry: {}, onReturnToHome: {})
}
