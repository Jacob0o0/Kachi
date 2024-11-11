//
//  Coversacion.swift
//  KachiV
//
//  Created by Karla Tovar on 12/10/24.
//

import SwiftUI

struct Coversacion: View {
    let text: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                    .foregroundColor(color)
                    .font(.title2)
                    .bold()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(radius: 3)
                    )
            }
            .padding()
        }
    }
}

#Preview {
    Coversacion(text: "Tengo el corazón aplastado", color: .rosaMexicano)
}
