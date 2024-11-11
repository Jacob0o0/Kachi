//
//  JuegosView.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 26/10/24.
//

import SwiftUI

struct JuegosView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Imagen de fondo
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125, height: 125)
                        
                        VStack {
                            Text("¡Bienvenido!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.rosaMexicano)
                                .padding(.bottom, 5)
                            
                            Text("Listo para aprender")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.top, -10)
                        }
                        .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    .background(Color.azulMexicano)
                    .cornerRadius(10)
                    .padding(.top, 40)

                    NavigationButton(buttonText: "Juego de Memoria", destinationView: MemoryGameView())
                        .padding(.top, 20)

                    NavigationButton(buttonText: "Quiz de Imagenes", destinationView: ImageQuizView())
                        .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
            }
        }    }
}

#Preview {
    JuegosView()
}
