//
//  CardUsuario.swift
//  Kachi
//
//  Created by CEDAM17 on 10/10/24.
//

import SwiftUI

struct CardAprende: View {
    let alto: CGFloat
    let ancho: CGFloat
    let titulo: String
    let subtitulo: String
    let progreso: Float
    let racha: String
    let colorTexto: Color
    let background: Color
    let iconoFondo: Image
    let iconoAvatar: Image

    var body: some View {
        ZStack {
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

            HStack(alignment: .center) {

                VStack(alignment: .center) {
                    Text(titulo)
                        .font(.title)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(colorTexto)

                        Text(subtitulo)
                            .font(.caption)
                            .foregroundStyle(colorTexto)
                        ProgressView(value: 4, total: 10)
                            .accentColor(.amarilloMexicano)
                    }

                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(colorTexto)

                        Spacer()
                        Text(racha)
                            .font(.subheadline)
                            .foregroundStyle(colorTexto)

                    }
                    
                    Button(action: {
                        print("Botón 'Sigue aprendiendo' presionado")
                    }) {
                        Text("Sigue aprendiendo")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(Color.amarilloMexicano)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                iconoAvatar
                    .resizable()
                    .scaledToFit()
                    .frame(height: alto)
                    .frame(maxWidth: .infinity)
                    .clipped()
            }
            .padding(.trailing, 0)
        }
        .padding()
        .frame(width: ancho, height: alto)
    }
}

#Preview {
    CardAprende(
        alto: CGFloat(220),
        ancho: CGFloat(370),
        titulo: "Curso 1: Lo Esencial",
        subtitulo: "4/15",
        progreso: 10,
        racha: "14 días de racha",
        colorTexto: .white,
        background: .moradoMexicano,
        iconoFondo: Image("fondo_card"),
        iconoAvatar: Image("trajinera")
    )
}
