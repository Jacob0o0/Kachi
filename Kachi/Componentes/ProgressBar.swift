import SwiftUI

// Componente de barra de progreso con ProgressView
struct ProgressBar: View {
    var progress: CGFloat // Progreso entre 0 y 1
    var animationDuration: Double // Duración de la animación

    var body: some View {
        ProgressView(value: progress)
            .progressViewStyle(LinearProgressViewStyle(tint: Color(.rosaMexicano
                                                                  ))) // Personaliza el color con hex
            .scaleEffect(x: 1, y: 4, anchor: .center) // Aumenta el grosor de la barra
            .animation(.linear(duration: animationDuration), value: progress)
            
    }
}

#Preview {
    VStack {
        // Progreso normal
        ProgressBar(progress: 0.8, animationDuration: 0.5) // Duración rápida
            .frame(height: 20)
            .padding()

        // Progreso lento
        ProgressBar(progress: 0.3, animationDuration: 2.0) // Duración lenta
            .frame(height: 20)
            .padding()
    }
}
