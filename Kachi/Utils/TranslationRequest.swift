//
//  TranslationRequest.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 25/10/24.
//

import Foundation

struct TranslationRequest: Codable {
    let sentence: String
}

struct TranslationResponse: Codable {
    let translation: String
}

func translate(sentence: String, completion: @escaping (String?) -> Void) {
    // URL del endpoint de la API
    guard let url = URL(string: "https://6032-132-248-80-176.ngrok-free.app/translate") else {
        completion(nil)
        return
    }
    
    // Crear la solicitud
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Configurar el cuerpo de la solicitud
    let requestBody = TranslationRequest(sentence: sentence)
    guard let jsonData = try? JSONEncoder().encode(requestBody) else {
        completion(nil)
        return
    }
    request.httpBody = jsonData
    
    // Realizar la solicitud
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error en la solicitud: \(error?.localizedDescription ?? "Sin descripción")")
            completion("La traducción no está disponible en este momento")
            return
        }
    
        // Imprimir la respuesta cruda para verificar su contenido
        if let responseString = String(data: data, encoding: .utf8) {
            print("Respuesta del servidor: \(responseString)")
        }
        
        // Intentar decodificar la respuesta
        do {
            let translationResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
            completion(translationResponse.translation)
        } catch {
            print("Error al decodificar la respuesta: \(error.localizedDescription)")
            completion("La traducción no está disponible en este momento")
        }
    }.resume()
}
