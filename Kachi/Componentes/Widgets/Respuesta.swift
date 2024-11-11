//
//  Coversacion.swift
//  KachiV
//
//  Created by Karla Tovar on 12/10/24.
//

import SwiftUI

struct Respuesta: View {
    var body: some View {
        HStack {
            Image(systemName: "speaker.wave.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.rosaMexicano)
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 3)
                .overlay(
                    VStack(alignment: .trailing) {
                        Text("Quen otimotlanextilih notlazohtzin")
                            .foregroundColor(Color(.azulMexicano))
                            .font(.system(size: 16))
                            .bold()
                           
                        
                        Divider()
                           
                        
                        Text("¿Cómo amaneciste, amor mío?")
                            .foregroundColor(.rosaMexicano)
                            
                    }
                    .padding()
                )
                .frame(width: 236, height:130)
                .padding()
                
        }
        .padding()
    }
}

#Preview {
    Respuesta()
}
