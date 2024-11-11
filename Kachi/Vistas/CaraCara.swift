//
//  CaraCara.swift
//  KachiV
//
//  Created by Karla Tovar on 12/10/24.
//

import SwiftUI

struct CaraCara: View {
    @Binding var isPresented: Bool
    @Namespace var bottomID
    @State private var isMicPressed: Bool = false
    
    @State private var liveText: String = "" // Texto en tiempo real
    @State private var translatedText: String = ""
    
    private let speechSynthesizer = SpeechSynthesizer()
    @State var speechRecognizer = SpeechRecognizer()
    
    @State private var mensajesEs: [String] = []
    @State private var mensajesLen: [String] = []


    var body: some View {
        ZStack {
            
            VStack {

                Button(action: {
                    isPresented.toggle()})
                {
                    Image(systemName: "x.square.fill")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .foregroundColor(Color.grisMexicano)
                        .frame(width: 30, height: 30)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                
               
                VStack {
                    ScrollViewReader{ proxy in
                        ScrollView {
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    speechSynthesizer.speak(text: "¿Cómo amaneciste, amor mío?")
                                }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.azulMexicano)
                                }
                                
                                Coversacion(text: "¿Cómo amaneciste, amor mío?", color: .azulMexicano)
                                
                            }
                            
                            HStack{
                                Coversacion(text: "Te extraño.", color: .rosaMexicano)
                                
                                Button(action: {
                                    speechSynthesizer.speak(text: "Te extraño")
                                }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.rosaMexicano)
                                }
                                
                                Spacer()
                            }
                            
                            // Muestra todos los mensajes estáticos
                            ForEach(mensajesEs, id: \.self) { mensaje in
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        speechSynthesizer.speak(text: mensaje)
                                    }) {
                                        Image(systemName: "speaker.wave.2.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.azulMexicano)
                                    }
                                    
                                    Coversacion(text: mensaje, color: .azulMexicano)
                                }
                                .id(mensaje)
                            }
                            
                            // HStack para el texto en tiempo real
                            if isMicPressed {
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        speechSynthesizer.speak(text: liveText)
                                    }) {
                                        Image(systemName: "speaker.wave.2.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.azulMexicano)
                                    }
                                    
                                    Coversacion(text: liveText, color: .azulMexicano)
                                }
                                .id(bottomID)
                            }
                        }
                        .onChange(of: mensajesEs) { _ in
                            // Desplaza el ScrollView al último mensaje cuando la transcripción termine
                            if !isMicPressed, let lastMessage = mensajesEs.last {
                                proxy.scrollTo(lastMessage, anchor: .bottom)
                            }
                        }
                        .onChange(of: isMicPressed) { _ in
                            // Desplaza el ScrollView al liveText en tiempo real
                            if isMicPressed {
                                proxy.scrollTo(bottomID, anchor: .bottom)
                            }
                        }
                    }
                    
                    Button(action: {
                        isMicPressed.toggle()
                        if isMicPressed {
                            liveText = ""
                            speechRecognizer.startTranscribing { result in
                                DispatchQueue.main.async {
                                    liveText = result
                                }
                            }
                        } else {
                            speechRecognizer.stopTranscribing()
                            mensajesEs.append(liveText)
                            
                            translate(sentence: liveText) { translation in
                                if let translatedTextResult = translation {
                                    DispatchQueue.main.async {
                                        translatedText = translatedTextResult.replacingOccurrences(of: "\n", with: " ")
                                        
                                        mensajesLen.append(translatedTextResult)
                                    }
                                }
                            }
                            
                            
                            liveText = ""
                        }
                    }) {
                        VStack {
                            Image(systemName: isMicPressed ? "mic.fill" : "mic")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        }
                        .frame(width: 70, height: 70)
                        .background(Color.rosaMexicano)
                        .clipShape(Circle())
                        .padding(.top, 20)
                    }
                    
                }.rotationEffect(.degrees(180))

                Divider()
                    .foregroundStyle(.black)
                    .padding()
                
                
                VStack {
                    ScrollViewReader{ proxyL in
                        ScrollView {
                            
                            HStack{
                                Coversacion(text: "Quen otimotlanextilih notlazohtzin?", color: .rosaMexicano)
                                
                                
                                Button(action: {
                                    speechSynthesizer.speak(text: "Quen otimotlanextilih notlazohtzin?")
                                }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.rosaMexicano)
                                }
                                
                                
                                Spacer()
                            }
                            
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    speechSynthesizer.speak(text: "Mitztemoa noyollo.")
                                }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.azulMexicano)
                                }
                                
                                Coversacion(text: "Mitztemoa noyollo.", color: .azulMexicano)
                                
                            }
                            
                            // Muestra todas las traducciones estáticas
                            ForEach(mensajesLen, id: \.self) { mensajeLen in
                                HStack {
                                    Coversacion(text: mensajeLen, color: .rosaMexicano)
                                    
                                    
                                    Button(action: {
                                        speechSynthesizer.speak(text: mensajeLen)
                                    }) {
                                        Image(systemName: "speaker.wave.2.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.rosaMexicano)
                                    }
                                    
                                    
                                    Spacer()
                                }
                                .id(mensajeLen)
                            }
                        }
                        .onChange(of: mensajesLen) { _ in
                            // Desplaza el ScrollView al último mensaje cuando la transcripción termine
                            if !isMicPressed, let lastMessage = mensajesLen.last {
                                proxyL.scrollTo(lastMessage, anchor: .bottom)
                            }
                        }
                    }

                    
                    Button(action: { isMicPressed.toggle() }) {
                        VStack {
                            Image(systemName: isMicPressed ? "mic.fill" : "mic")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        }
                        .frame(width: 70, height: 70)
                        .background(Color.rosaMexicano)
                        .clipShape(Circle())
                        .padding(.top, 20)
                    }
                }
            }
            .padding(.bottom)
        }
        .background(
            ZStack{
                Image("patron-light")
                    .resizable()
                    .scaledToFill()
            }
        )
       
    }
}

#Preview {
    StateWrapper(isPresented: true)
}

struct StateWrapper: View {
    @State var isPresented: Bool

    var body: some View {
        CaraCara(isPresented: $isPresented)
    }
}
