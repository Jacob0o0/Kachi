//
//  TextDetectionView.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 21/10/24.
//

import SwiftUI
import Vision
import PhotosUI

// Modelo para el texto detectado
struct DetectedText {
    let id = UUID()
    let text: String
    let boundingBox: CGRect
}

struct TextDetectionView: View {
    @Binding var isPresented: Bool

    @State var image: UIImage?
    @State private var detectedTexts: [DetectedText] = []
    @State private var showImagePicker = false
    @State private var imageSize: CGSize = .zero  // Para almacenar el tamaño de la imagen
       
    private let speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        VStack {
            Button(action: {
                isPresented.toggle()
            }) {
                Image("X")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .foregroundColor(Color.black)
                    .frame(width: 30, height: 30)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            if let image = image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .background(
                            GeometryReader { geometry in
                                Color.clear.onAppear {
                                    // Almacena el tamaño de la imagen
                                    imageSize = geometry.size
                                }
                            }
                        )
                        .overlay {
                            ForEach(detectedTexts, id: \.id) { detectedText in
                                Rectangle()
                                    .stroke(Color.red, lineWidth: 2)
                                    .background(Color.clear)
                                    .frame(width: detectedText.boundingBox.width, height: detectedText.boundingBox.height)
                                    .position(x: detectedText.boundingBox.midX, y: detectedText.boundingBox.midY)
                                    .onTapGesture {
                                        // Acciones al presionar el recuadro
                                        speechSynthesizer.speak(text: detectedText.text) // Inicia la síntesis de voz
                                    }
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.azulMexicano)
                .cornerRadius(20)
            } else {
                Button {
                    showImagePicker = true
                } label: {
                    Text("Selecciona una imagen")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.azulMexicano)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
   
            }
            
            Button {
                showImagePicker = true
            } label: {
                Text("Traducir")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.rosaMexicano)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .onAppear {
            // Abre el selector de imágenes al aparecer la vista
            showImagePicker = true
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
        .onChange(of: image) { newImage in
            if let image = newImage {
                detectText(in: image)
            }
        }
    }

    private func detectText(in image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (request, error) in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                DispatchQueue.main.async {
                    self.detectedTexts = observations.map { observation in
                        let text = observation.topCandidates(1).first?.string ?? ""
                        let boundingBox = self.boundingBox(for: observation)
                        return DetectedText(text: text, boundingBox: boundingBox)
                    }
                }
            }
        }

        do {
            try requestHandler.perform([request])
        } catch {
            print("Error detectando texto: \(error)")
        }
    }

    private func boundingBox(for observation: VNRecognizedTextObservation) -> CGRect {
        guard imageSize != .zero else { return .zero }  // Asegúrate de que el tamaño de la imagen esté disponible

        // Convierte las coordenadas de la observación a coordenadas de la imagen
        let boundingBox = observation.boundingBox
        // Calcula el factor de escala
        let scaleX = imageSize.width
        let scaleY = imageSize.height
        
        // Ajusta las coordenadas para que se alineen correctamente con la vista de la imagen
        let width = boundingBox.width * scaleX
        let height = boundingBox.height * scaleY
        let originX = boundingBox.minX * scaleX
        let originY = (1 - boundingBox.maxY) * scaleY // Invertir Y porque Vision usa un sistema de coordenadas diferente
        return CGRect(x: originX, y: originY, width: width, height: height)
    }
}

#Preview {
    StateWrapperTextDetection(isPresented: true)
}

struct StateWrapperTextDetection: View {
    @State var isPresented: Bool

    var body: some View {
        TextDetectionView(isPresented: $isPresented)
    }
}
