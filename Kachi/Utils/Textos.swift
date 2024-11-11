//
//  Textos.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 25/10/24.
//


import Foundation

struct Textos {
    // Diccionario de textos según idioma y clave
    private static let textos: [String: [String: String]] = [
        "español": [
            "saludo": "¡Buen día!",
            "despedida": "¡Hasta luego!",
            "bienvenida": "Bienvenidos a nuestra app"
        ],
        "nahuatl": [
            "saludo": "¡Mah cualli tonalli!",
            "despedida": "¡Timo itta!",
            "bienvenida": "Ximopanoltih tech"
        ],
        "otomi": [
            "saludo": "¡Ki hats'i!",
            "despedida": "¡Dí kwatsi!",
            "bienvenida": "Hña ja ko jatsi"
        ],
        "totonaco": [
            "saludo": "¡Kuinilh!",
            "despedida": "¡Xlakakgla!",
            "bienvenida": "Makat tanintuku"
        ]
    ]
    
    // Método para obtener el texto según el idioma y la clave
    static func obtenerTexto(idioma: String, clave: String) -> String {
        return textos[idioma]?[clave] ?? "Texto no disponible"
    }
}
