//
//  KachiApp.swift
//  Kachi
//
//  Created by CEDAM17 on 20/09/24.
//

import SwiftUI

@main
struct KachiApp: App {
    @StateObject private var configLengua = ConfiguracionLengua()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(configLengua)
        }
    }
}
