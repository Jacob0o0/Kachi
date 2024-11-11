import SwiftUI

struct Minijuego: View {
    let alto: CGFloat
    let ancho: CGFloat
    let titulo: String
    let subtitulo: String
    let colorTexto: Color
    let background: Color
    let iconoFondo: Image
    let iconoAvatar: Image
    let destinationView: AnyView // Vista de destino que se puede cambiar dinámicamente

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Fondo y color de fondo
            RoundedRectangle(cornerRadius: 20)
                .fill(background)
                .frame(width: ancho, height: alto)
                .overlay {
                    iconoFondo
                        .resizable()
                        .scaledToFill()
                        .frame(width: ancho, height: alto)
                        .clipped()
                }

            // Avatar en el fondo, alineado a la esquina inferior izquierda
            iconoAvatar
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150) // Tamaño del avatar
                .position(x: ancho * 0.3, y: alto * 0.7) // Ajuste para colocarlo en la esquina inferior izquierda

            VStack(alignment: .leading) {
                // Textos en la parte superior izquierda
                VStack(alignment: .leading, spacing: 5) {
                    Text(titulo)
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text(subtitulo)
                        .font(.caption)
                        .foregroundColor(colorTexto)
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                
                Spacer()

                HStack {
                    Spacer()

                    // NavigationLink en lugar de Button para navegar a la vista de destino
                    NavigationLink(destination: destinationView) {
                        Text("¡Juega ahora!")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
                }
            }
            .frame(width: ancho, height: alto)
        }
        .padding()
        .frame(width: ancho, height: alto)
        .clipped()
    }
}

#Preview {
    NavigationView {
        Minijuego(
            alto: CGFloat(230),
            ancho: CGFloat(170),
            titulo: "Memorama",
            subtitulo: "¡Desafía tu memoria!",
            colorTexto: .white,
            background: .amarilloMexicano,
            iconoFondo: Image("fondo_card"),
            iconoAvatar: Image("avatar"),
            destinationView: AnyView(MemoryGameView())
        )
    }
}
