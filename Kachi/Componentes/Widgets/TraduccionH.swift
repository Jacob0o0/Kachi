//
//  TraduccionH.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 25/10/24.
//

import SwiftUI
import AVFoundation

struct TraduccionH: View {
    let deLengua: String
    let aLengua: String
    let textoOriginal: String
    let textoTraducido: String
    
    private let speechSynthesizer = SpeechSynthesizer()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(deLengua)
                        .font(.title2)
                        .foregroundStyle(.verdeAguaMexicano)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading){
                            Text(textoOriginal)
                                .bold()
                                .font(.title)
                                .accentColor(.white)
                                .foregroundColor(.verdeAguaMexicano)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            speechSynthesizer.speak(text: textoOriginal)
                        } label: {
                            Image(systemName: "speaker.wave.2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.verdeAguaMexicano)
                        }
    
                    }
                    .cornerRadius(10)

                }
                .padding()
                
                Divider()
                    .background(Color.white)
                
                VStack(alignment: .leading) {
                    Text(aLengua)
                        .font(.title2)
                        .foregroundStyle(.verdeAguaMexicano)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading){
                            Text(textoTraducido)
                                .bold()
                                .font(.title)
                                .accentColor(.white)
                                .foregroundColor(.verdeAguaMexicano)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            speechSynthesizer.speak(text: textoTraducido)
                        } label: {
                            Image(systemName: "speaker.wave.2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.verdeAguaMexicano)
                        }
    
                    }
                    .cornerRadius(10)
                }
                .padding()
                
                HStack{
                    Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 40)
                        .foregroundColor(.verdeAguaMexicano)
                        .padding(.trailing)
                    
                    Image(systemName: "document.on.document")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.verdeAguaMexicano)
                }
                .padding()
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 3)
                .padding(.leading)
                .padding(.trailing)
        )
    }
}

#Preview {
    TraduccionH(deLengua: "Español", aLengua: "Náhuatl", textoOriginal: "Buenos días", textoTraducido: "Kuali Tonali")
}
