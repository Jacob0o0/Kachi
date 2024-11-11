import SwiftUI
import UIKit
import AVFoundation
import Speech

struct Traductor: View {
    @State private var selectedView = 0
    @State private var selectedLanguage = "Español"
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showDocumentPicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedDocument: URL?
    @State private var isMicPressed: Bool = false
    @State private var isFullScreen = false
    @State private var imageToText = false
    
    @StateObject private var traduccionStore = TraduccionStore()
    
    @State private var mensajes: [String] = ["Hola, ¿cómo estás?"]
    @State private var traduccion: [String] = ["Kuix ken tikaj?"]
    
    @State private var mensajesR: [String] = []
    @State private var traduccionR: [String] = []
    
    @State private var liveText: String = ""
    @State private var translatedText: String = ""
    
    private let speechSynthesizer = SpeechSynthesizer()
    @State var speechRecognizer = SpeechRecognizer()
    
    let languages = ["Español", "Nahuatl", "Otomí", "Totonaco"]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .azulMexicano
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(selectedView == 0 ? "Traducir" : "Conversación")
                            .font(.largeTitle)
                            .padding()
                            .bold()
                        
                        Spacer()
                        Picker("Idioma", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language).tag(language)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .cornerRadius(20)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.azulMexicano))
                        .accentColor(Color.white)
                        .padding(.trailing)
                    }
                    HStack{
                        Picker("Selecciona una opción", selection: $selectedView) {
                            Text("Traductor").tag(0)
                            Text("Conversación").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.cieloMexicano))
                        .cornerRadius(20)
                        .frame(width: 200)
                        .padding(.leading)
                        
                        Spacer()
                        
                        // Botón para mostrar FullScreenView
                        Button {
                            isFullScreen.toggle()
                        } label: {
                            Image(systemName: "person.line.dotted.person.fill")
                                .padding(5)
                                .foregroundColor(.white)
                                .background(.rosaMexicano)
                                .cornerRadius(30)
                                .bold()
                        }
                        .padding(.trailing)

                    }
                    
                    
                    
                    if selectedView == 0 {
                        ZStack{
                            VStack {
                                
                                ScrollView {
                                    Traducir(traduccionStore: traduccionStore)
                                    
                                    // Muestra cada traducción en una vista separada
                                    ForEach(traduccionStore.traducciones) { traduccion in
                                        TraduccionH(
                                            deLengua: traduccion.deLengua,
                                            aLengua: traduccion.aLengua,
                                            textoOriginal: traduccion.textoOriginal,
                                            textoTraducido: traduccion.textoTraducido
                                        )
                                        .padding(.leading)
                                        .padding(.trailing)
                                        .transition(.move(edge: .top)) // Aparece desde la parte superior
                                        .animation(.easeInOut, value: traduccionStore.traducciones)
                                    }
                                    
                                    TraduccionH(deLengua: "Español", aLengua: "Náhuatl", textoOriginal: "Buenos días", textoTraducido: "Kuali Tonali")
                                        .padding(.leading)
                                        .padding(.trailing)
                                        .padding(.bottom)
                                    
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 80)
                                }
                            }
                            
                            VStack{
                                Spacer()
                                
                                HStack {
                                    Button(action: {
                                        imageToText.toggle()
                                    }) {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(10)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 40, height: 40)
                                    .background(Color.grisMexicano)
                                    .clipShape(Circle())
                                    .padding(.top, 20)
                                    
                                    
                                    Button(action: { showCamera = true }) {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 70, height: 70)
                                    .background(Color.rosaMexicano)
                                    .clipShape(Circle())
                                    
                                    Button(action: { showDocumentPicker = true }) {
                                        Image(systemName: "folder")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(10)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 40, height: 40)
                                    .background(Color.grisMexicano)
                                    .clipShape(Circle())
                                    .padding(.top, 20)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 20)
                            }
                        }
                    } else {
                        VStack {
                            ScrollViewReader{ proxy in
                                ScrollView{
                                    VStack{
                                        ForEach(mensajes.indices, id: \.self) { index in
                                            HStack{
                                                Conversacion2(originalText: mensajes[index], translatedText: traduccion[index])
                                                    .padding()
                                                
                                                Button(action: {
                                                    speechSynthesizer.speak(text: traduccion[index])
                                                }) {
                                                    Image(systemName: "speaker.wave.2.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                        .foregroundColor(.rosaMexicano)
                                                }
                                                
                                                Spacer()
                                            }
                                            .id("mensaje-\(index)")
                                        }
                                        
                                        ForEach(mensajesR.indices, id: \.self) { index in
                                            HStack{
                                                Spacer()
                                                
                                                Button(action: {
                                                    speechSynthesizer.speak(text: traduccion[index])
                                                }) {
                                                    Image(systemName: "speaker.wave.2.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                        .foregroundColor(.rosaMexicano)
                                                }
                                                
                                                Conversacion2(originalText: mensajes[index], translatedText: traduccion[index])
                                                    .padding()
                                            }
                                            .id("mensajeR-\(index)")
                                        }
                                    }
                                    .onAppear{
                                        scrollToBottom(proxy: proxy)
                                    }
                                    .onChange(of: mensajes) { _ in
                                        scrollToBottom(proxy: proxy)
                                    }
                                    .onChange(of: mensajesR) { _ in
                                        scrollToBottom(proxy: proxy)
                                    }
                                }
                            }
                            .frame(maxHeight: .infinity)

                            HStack {
                                Spacer()
                                
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
                                        mensajes.append(liveText)
                                        
                                        translate(sentence: liveText) { translation in
                                            if let translatedTextResult = translation {
                                                DispatchQueue.main.async {
                                                    translatedText = translatedTextResult.replacingOccurrences(of: "\n", with: " ")
                                                    
                                                    traduccion.append(translatedTextResult)
                                                }
                                            }
                                        }
                                        
                                        
                                        liveText = ""
                                    }
                                }) {
                                    VStack{
                                        Image(systemName: isMicPressed ? "mic.fill" : "mic")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                        
                                        Text("Español")
                                            .foregroundColor(.white)
                                            .font(.system(size: 9))
                                    }
                                    .frame(width: 70, height: 70)
                                    .background(Color.rosaMexicano)
                                    .clipShape(Circle())
                                    
                                }
                                
                                Spacer()
                                
                                Button(action: { isMicPressed.toggle() }) {
                                    VStack {
                                        Image(systemName: isMicPressed ? "mic.fill" : "mic")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                        Text("Náhuatl")
                                            .foregroundColor(.white)
                                            .font(.system(size: 9))
                                    }
                                }
                                .frame(width: 70, height: 70)
                                .background(Color.azulMexicano)
                                .clipShape(Circle())
                                
                                Spacer()
                            }
                            .frame(alignment: .center)
                        }
                        .padding(.bottom, 20)
                    }
                    
                }
                .navigationBarTitle("", displayMode: .inline)
                .sheet(isPresented: $showCamera) {
                    CameraView()
                }
                .sheet(isPresented: $showDocumentPicker) {
                    DocumentPicker(url: $selectedDocument)
                }
                .fullScreenCover(isPresented: $isFullScreen) {
                    CaraCara(isPresented: $isFullScreen)
                }
                .fullScreenCover(isPresented: $imageToText){
                    TextDetectionView(isPresented: $imageToText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 50)
            .background(
                ZStack{
                    Image("patron-light")
                        .resizable()
                        .scaledToFill()
                }
            )
        }
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        withAnimation {
            if let lastMensajeIndex = mensajes.indices.last {
                proxy.scrollTo("mensaje-\(lastMensajeIndex)", anchor: .bottom)
            } else if let lastMensajeRIndex = mensajesR.indices.last {
                proxy.scrollTo("mensajeR-\(lastMensajeRIndex)", anchor: .bottom)
            }
        }
    }
}

#Preview {
    Traductor()
}
