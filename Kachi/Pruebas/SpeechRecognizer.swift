//
//  SpeechRecognizer.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 26/10/24.
//

import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-ES"))  // Español
    private var request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?

    func startTranscribing(completion: @escaping (String) -> Void) {
        // Pedir autorización de reconocimiento de voz
        requestSpeechAuthorization { authorized in
            guard authorized else { return }

            // Reiniciar el request y el reconocimiento en cada transcripción
            self.request = SFSpeechAudioBufferRecognitionRequest()
            self.prepareAudioEngine()
            
            // Configurar la tarea de reconocimiento
            self.recognitionTask = self.speechRecognizer?.recognitionTask(with: self.request) { result, error in
                guard let result = result else {
                    if let error = error {
                        print("Error recognizing speech: \(error)")
                    }
                    return
                }
                completion(result.bestTranscription.formattedString)
            }
            
            // Iniciar el audio engine
            self.startAudioEngine()
        }
    }

    func stopTranscribing() {
        // Detener y reiniciar el audioEngine y la recognitionTask
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            audioEngine.reset()
        }
        
        // Cancelar la tarea de reconocimiento
        recognitionTask?.cancel()
        recognitionTask = nil
        request.endAudio()  // Finaliza el flujo de audio para liberar recursos
    }

    private func requestSpeechAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                completion(authStatus == .authorized)
            }
        }
    }

    private func prepareAudioEngine() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
    }

    private func startAudioEngine() {
        audioEngine.prepare()
        try? audioEngine.start()
    }
}
