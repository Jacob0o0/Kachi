import SwiftUI
import UIKit
import AVFoundation
import Speech

struct Traducir: View {
    @ObservedObject var traduccionStore: TraduccionStore
    
    @State private var originalLanguage: String = "Español"
    @State private var targetLanguage: String = "Nahuatl"
    @State private var originalText: String = ""
    @State private var translatedText: String = ""
    
    @State private var isMicPressed: Bool = false
    
    @State private var inputSentence: String = ""
    
    @State private var recognizedText = ""
    @State private var isRecording = false
    
    @State var speechRecognizer = SpeechRecognizer()

    let languages = ["Español", "Nahuatl", "Otomí", "Totonaco"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Picker("Idioma Original", selection: $originalLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(Color.white)
                    
                    VStack {
                        HStack(alignment: .top) {
                            AutoSizingTextField(text: $originalText, placeholder: "Introduce texto")
                                .bold()
                                .font(.title)
                                .accentColor(.white)
                                .foregroundColor(.white)
                            
                            Button(action: {
                                if isRecording {
                                    speechRecognizer.stopTranscribing()
                                    
                                    translate(sentence: originalText) { translation in
                                        if let translatedTextResult = translation {
                                            DispatchQueue.main.async {
                                                translatedText = translatedTextResult.replacingOccurrences(of: "\n", with: " ")
                                                
                                                // Agregar la nueva traducción y guardar la lista
                                                let nuevaTraduccion = Traduccion(
                                                    deLengua: originalLanguage,
                                                    aLengua: targetLanguage,
                                                    textoOriginal: originalText,
                                                    textoTraducido: translatedText
                                                )
                                                traduccionStore.agregarTraduccion(nuevaTraduccion)
                                            }
                                        }
                                    }
                                    
                                } else {
                                    // Limpiar el campo de texto antes de iniciar una nueva transcripción
                                    originalText = ""
                                    translatedText = ""
                                    speechRecognizer.startTranscribing { result in
                                        originalText = result
                                    }
                                }
                                isRecording.toggle()
                            }) {
                                Image(systemName: isRecording ? "mic.fill" : "mic")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                            }
                            
                        }
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                    .foregroundStyle(.white)
                    .background(Color.white)
                    .frame(maxWidth: 300)
                
                VStack(alignment: .leading) {
                    Picker("Idioma de Traducción", selection: $targetLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(Color.white)
                    
                    VStack {
                        HStack(alignment: .top){
                            AutoSizingTextField(text: $translatedText, placeholder: "Introduce texto")
                                .bold()
                                .font(.title)
                                .accentColor(.white)
                                .foregroundColor(.white)
                            
                            Button(action: {
                                isMicPressed.toggle()
                                // Aquí puedes agregar la lógica para traducir el texto
                                print("Micrófono presionado")
                            }) {
                                Image(systemName: isMicPressed ? "mic.fill" : "mic")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rosaMexicano)
                .padding()
        )
    }
}

struct AutoSizingTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }
            TextEditor(text: $text)
                .frame(minHeight: 20, maxHeight: .infinity)
                .padding(0)
                .scrollContentBackground(.hidden)
        }
    }
}

//#Preview {
//    Traducir()
//}
