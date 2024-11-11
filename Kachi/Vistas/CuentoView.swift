//
//  ContentView.swift
//  KachiV
//
//  Created by CEDAM19 on 05/09/24.
//

import SwiftUI

struct CuentoView: View {
    let alto: CGFloat
    let titulo: String
    let fondo: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.azulMexicano)
                .frame(height: alto)
            
            Image(fondo)
                .resizable()
                .scaledToFill() // Usa scaledToFill si prefieres que llene el área
                .frame(height: alto)
                .cornerRadius(20)
                .clipped() // Recorta cualquier parte que exceda el ancho

            VStack(alignment: .leading){
                
                Spacer()
                
                Text(titulo)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(height: alto)
        
    }
}

#Preview {
    CuentoView(alto: 220, titulo: "Título en Español", fondo: "alacran_zanate")
}

