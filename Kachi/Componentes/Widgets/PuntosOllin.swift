import SwiftUI

struct PuntosOllin: View {
    
    let ancho: CGFloat
    let alto: CGFloat
    let colortexto: Color
    let background: Color
    let imagen: Image
    let icono: String
    let puntos: String
    
    var body: some View {
        HStack {
            imagen
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Spacer()
            
            HStack {
                Image(systemName: icono)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(colortexto)
                
                Text(puntos)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(colortexto)
            }
            
            Spacer() // Agregar Spacer para forzar el ajuste de altura
        }
        .padding()
        .frame(width: ancho, height: alto)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(background)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(colortexto, lineWidth: 1)
                )
                .shadow(radius: 3)
        )
       
    }
}

#Preview {
    PuntosOllin(
        ancho: CGFloat(200),
        alto: CGFloat(70),
        colortexto: .verdeAguaMexicano,
        background: .white,
        imagen: Image("Ollin"),
        icono: "arrow.up",
        puntos: "96"
    )
}
