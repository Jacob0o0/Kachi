//
//  ConfiguracionLengua.swift
//  Kachi
//
//  Created by Jacobo Escorcia on 25/10/24.
//

import SwiftUI
import Combine

class ConfiguracionLengua: ObservableObject {
    @Published var idiomaSeleccionado: String {
        didSet {
            UserDefaults.standard.set(idiomaSeleccionado, forKey: "idiomaSeleccionado")
        }
    }
    
    init() {
        self.idiomaSeleccionado = UserDefaults.standard.string(forKey: "idiomaSeleccionado") ?? "español"
    }
}
