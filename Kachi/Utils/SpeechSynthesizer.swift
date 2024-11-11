//
//  SpeechSynthesizer.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 30/10/24.
//


import AVFoundation

class SpeechSynthesizer {
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    func speak(text: String) {
        // Detener cualquier síntesis de voz en curso
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        // Crear un objeto de síntesis de voz con el texto
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX") // Cambia el idioma si es necesario
        
        // Iniciar la síntesis de voz
        speechSynthesizer.speak(utterance)
    }

}
