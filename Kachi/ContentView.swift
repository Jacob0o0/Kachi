//
//  ContentView.swift
//  KachiV
//
//  Created by CEDAM19 on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab : Tab = .house
    @State private var selectedTabs: [String] = []
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack{
            
            TabView(selection: $selectedTab) {
                Home()
                    .tag(Tab.house)
                
                Aprende()
                    .tag(Tab.medal)

                Traductor()
                    .tag(Tab.bubble)

                Perfil()
                    .tag(Tab.person)
                
            }
            .edgesIgnoringSafeArea(.bottom)

            
            VStack {
                Spacer()
                Navbar(selectedTab: $selectedTab)
                .padding(.bottom, 10) // Ajusta el padding inferior según sea necesario
                }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(
            ZStack{
                Image("patronAzul")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.10)
            }
        )
    }
}

#Preview {
    ContentView()
}

