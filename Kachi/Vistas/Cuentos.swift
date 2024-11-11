//
//  Cuentos.swift
//  KachiV
//
//  Created by CEDAM19 on 08/10/24.
//

import SwiftUI

struct Paragraph {
    let es: String
    let en: String
}

struct Story {
    let titleEs: String
    let titleEn: String
    let paragraphs: [Paragraph]
    let imageName: String
}

struct Cuentos: View {
    let relato: Historia
    
    @State private var isSpanish = true
    @State private var currentStoryIndex = 0
    
    private let speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        VStack {
            ScrollView {
                ZStack{
                    Image(relato.imagen)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .overlay(
                            Color.black
                                .opacity(0.2)
                        )
                        .blur(radius: 2)
                        .clipped()
                    
                    VStack(alignment: .leading){
                        
                        HStack(){
                            Spacer()
                            
                            // Botón para cambiar entre idiomas
                            Button(action: {
                                isSpanish.toggle()
                            }) {
                                Text(isSpanish ? "Nahuatl" : "Español")
                                    .padding()
                                    .background(Color.azulMexicano)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 40)
                        .padding()
                        
                        Spacer()
                        
                        HStack{
                            VStack{
                                Text(isSpanish ? relato.titulo_español : relato.titulo_nahuatl ?? relato.titulo_español)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Image(systemName: "suit.heart")
                                .font(.title)
                                .foregroundStyle(.white)
                            Button(action: {
                                isSpanish.toggle()
                            }) {
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.title)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding()

                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxHeight: 300)
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(relato.parrafos.indices, id: \.self) { index in
                        HStack(alignment: .top){
                            Button(action: {
                                // Llama al método para narrar el texto
                                speechSynthesizer.speak(text: isSpanish ? relato.parrafos[index].español : relato.parrafos[index].nahuatl ?? "Error")
                            }) {
                                Image(systemName: "speaker.wave.3")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.azulMexicano)
                                    .padding(.top, 3)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                // Mostrar texto en el idioma seleccionado
                                Text(isSpanish ? relato.parrafos[index].español : relato.parrafos[index].nahuatl ?? "Error")
                                    .font(.title3)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Mostrar traducción en el otro idioma
                                Text((isSpanish ? relato.parrafos[index].nahuatl : relato.parrafos[index].español ?? "Error") ?? "Error")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding()
                    
                    
                    Rectangle().fill(.clear).frame(height: 80)
                }
                .frame(maxWidth: .infinity)
            }
            .background(
                ZStack{
                    Image("patron-light")
                        .resizable()
                        .scaledToFill()
                }
            )
        }
        
        .ignoresSafeArea(.all)
    }
}


#Preview {
    Cuentos(relato: AppData.shared.cuentos[0])
}
