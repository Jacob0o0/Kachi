//
//  CuadradoIcon.swift
//  KachiV
//
//  Created by Karla Tovar on 18/10/24.
//

import SwiftUI

import SwiftUI

struct CuadradoIcon: View {
    let alto: CGFloat
    let ancho: CGFloat
    let titulo: String
    let subtitulo: String
    let colortexto: Color
    let background: Color
    let icono: Image
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(background)
                .frame(width: ancho, height: alto)
                
            VStack(alignment: .center){
               
                icono
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(colortexto)
                    .frame(height: 70)
                    .padding()
                
                Text(titulo)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(colortexto)
                    
                Text(subtitulo)
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(colortexto)
                    .padding(.bottom)
            }
            .padding()
        }
        .frame(width: ancho, height: alto)
    }
}

#Preview {
    CuadradoIcon(alto: CGFloat(160), ancho: CGFloat(170), titulo: "Relatos guardados", subtitulo: "Nahuatl - Español",colortexto: .white, background: .azulMexicano, icono: Image(systemName: "books.vertical"))
}



