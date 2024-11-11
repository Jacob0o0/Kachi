//
//  Navbar.swift
//  KachiV
//
//  Created by CEDAM19 on 09/10/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case medal
    case bubble
    case person
}

struct Navbar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }

    // Diccionario para personalizar los nombres de las vistas
    var tabNames: [Tab: String] = [
        .house: "Inicio",
        .medal: "Aprende",
        .bubble: "Traductor",
        .person: "Perfil"
    ]

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack {
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(selectedTab == tab ? 1.3 : 1.0)
                            .foregroundColor(selectedTab == tab ? .white : .gray)
                            .font(.system(size: 22))
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab
                                }
                            }
                        // Nombre de la vista debajo del ícono
                        if selectedTab == tab {
                            Text(tabNames[tab] ?? "")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .padding(.top, 4)
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 350, height: 65)
            .background(.azulMexicano)
            .cornerRadius(15)
            .padding()
        }
    }
}

#Preview {
    Navbar(selectedTab: .constant(.house))
}
