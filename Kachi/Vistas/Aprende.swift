//
//  CuadradoIcon.swift
//  KachiV
//
//  Created by Karla Tovar on 18/10/24.
//


import SwiftUI

struct Aprende: View {
   @ObservedObject var appData = AppData.shared
   @State private var selectedLanguage: String = "Nahuatl" // Valor predeterminado
   
   var filteredStories: [Historia] {
       appData.cuentos.filter { cuento in
           switch selectedLanguage {
           case "Nahuatl":
               return cuento.cultura_origen == "nahuatl"
           case "Español":
               return true // Show all stories when Spanish is selected
           case "Otomi":
               return cuento.cultura_origen == "otomi"
           case "Totonaco":
               return cuento.cultura_origen == "totonaco"
           default:
               return false
           }
       }
   }

   
   var body: some View {
       NavigationStack{
           VStack(alignment: .center) {
               ScrollView{
                   HStack{
                       
                       Text(
                           selectedLanguage == "Nahuatl" ? appData.saludo_dia.nahuatl ?? "¡Mah cualli tonalli!" :
                               selectedLanguage == "Español" ? appData.saludo_dia.español ?? "¡Buen día!" :
                               selectedLanguage == "Otomi" ? appData.saludo_dia.otomi ?? "¡Ki hats'i!" :
                               "¡Kuinilh!"
                       )
                       .font(.title)
                       .fontWeight(.medium)
                       
                       Spacer()
                       
                       Picker("Idioma", selection: $selectedLanguage) {
                           Text("Náhuatl").tag("Nahuatl")
                           Text("Español").tag("Español")
                           Text("Otomí").tag("Otomi")
                           Text("Totonaco").tag("Totonaco")
                       }
                       .pickerStyle(MenuPickerStyle())
                       .background(Color.azulMexicano) // Cambia el color de fondo del Picker
                       .cornerRadius(8) // Agrega esquinas redondeadas
                       .accentColor(Color.white)
                       .foregroundColor(.white) // Cambia el color del texto en general
                   }
                   .padding()
                   
                   
                   Divider()
                       .padding(.top, 0)
                       .padding(.leading)
                       .padding(.trailing)
                   
                   CardAprende(
                       alto: CGFloat(220),
                       ancho: CGFloat(370),
                       titulo: "Curso 1: Lo Esencial",
                       subtitulo: "4/15",
                       progreso: 10,
                       racha: "14 días de racha",
                       colorTexto: .white,
                       background: .moradoMexicano,
                       iconoFondo: Image("fondo_card"),
                       iconoAvatar: Image("trajinera")
                   )
                   
                   Spacer()
                   
                   HStack {
                       Text("Sugerencias")
                           .font(.headline) // Estilo del texto
                       Spacer()
                       Button(action: {
                           // Acción para el botón "Ver todo"
                       }) {
                           Text("Ver todo")
                               .font(.subheadline)
                               .foregroundColor(.blue) // Color del texto
                       }
                   }
                   .padding(.bottom, 0)
                   .padding(.leading)
                   .padding(.trailing)
                   
                   Divider()
                       .padding(.top, 0)
                       .padding(.leading)
                       .padding(.trailing)
                   
                   VStack(alignment: .leading) {
                       HStack{
                           Minijuego(
                               alto: CGFloat(220),
                               ancho: CGFloat(180),
                               titulo: "Memorama",
                               subtitulo: "¡Desafía tu memoria!",
                               colorTexto: .white,
                               background: .amarilloMexicano,
                               iconoFondo: Image("fondo_card"),
                               iconoAvatar: Image("avatar"),
                               destinationView: AnyView (MemoryGameView())
                           )
                           
                          
                           
                           Minijuego(
                               alto: CGFloat(220),
                               ancho: CGFloat(180),
                               titulo: "¿Qué es?",
                               subtitulo: "¡Adivina la imagen!",
                               colorTexto: .white,
                               background: .amarilloMexicano,
                               iconoFondo: Image("fondo_card"),
                               iconoAvatar: Image("avatar"),
                               destinationView: AnyView (ImageQuizView())
                           )
                        
                       }
                       HStack{
                           Minijuego(
                               alto: CGFloat(220),
                               ancho: CGFloat(180),
                               titulo: "Loteria",
                               subtitulo: "¡Desafía tu memoria!",
                               colorTexto: .white,
                               background: .amarilloMexicano,
                               iconoFondo: Image("fondo_card"),
                               iconoAvatar: Image("avatar"),
                               destinationView: AnyView (MemoryGameView())
                           )
                           
                          
                           
                           Minijuego(
                               alto: CGFloat(220),
                               ancho: CGFloat(180),
                               titulo: "Memorama",
                               subtitulo: "¡Desafía tu memoria!",
                               colorTexto: .white,
                               background: .amarilloMexicano,
                               iconoFondo: Image("fondo_card"),
                               iconoAvatar: Image("avatar"),
                               destinationView: AnyView (MemoryGameView())
                           )
                        
                       }
                      
                   }
                  
                  // aqui van los jueguitos
                   
                   
                   HStack(alignment: .bottom) {
                       VStack(alignment: .leading){
                           Text("Relatos de la semana")
                               .font(.headline) // Estilo del texto
                           Text("¡Sigue aprendiendo con historias!")
                               .font(.caption)
                       }
                       
                       Spacer()
                       Button(action: {
                           // Acción para el botón "Ver todo"
                       }) {
                           Text("Ver todo")
                               .font(.subheadline)
                               .foregroundColor(.blue) // Color del texto
                       }
                   }
                   .padding(.bottom, 0)
                   .padding(.leading)
                   .padding(.trailing)
                   
                   
                   Divider()
                       .padding(.top, 0)
                       .padding(.leading)
                       .padding(.trailing)
                   
                   VStack {
                       if AppData.shared.cuentosDestacados.count >= 3 {
                           HStack {
                               VStack {
                                   NavigationLink(
                                    destination: Cuentos(relato: AppData.shared.cuentosDestacados[0])
                                   ) {
                                       CuentoView(
                                        alto: CGFloat(150),
                                        titulo: AppData.shared.cuentosDestacados[0].titulo_nahuatl ?? AppData.shared.cuentosDestacados[0].titulo_español,
                                        fondo: AppData.shared.cuentosDestacados[0].imagen
                                       )
                                   }
                                   NavigationLink(
                                    destination: Cuentos(relato: AppData.shared.cuentosDestacados[0])
                                   ) {
                                       CuentoView(
                                        alto: CGFloat(90),
                                        titulo: AppData.shared.cuentosDestacados[0].titulo_nahuatl ?? AppData.shared.cuentosDestacados[0].titulo_español,
                                        fondo: AppData.shared.cuentosDestacados[0].imagen
                                       )
                                   }
                               }
                               .frame(maxWidth: .infinity)
                               
                               VStack {
                                   NavigationLink(
                                       destination: Cuentos(relato: AppData.shared.cuentosDestacados[1])
                                   ) {
                                       CuentoView(
                                           alto: CGFloat(90),
                                           titulo: AppData.shared.cuentosDestacados[0].titulo_nahuatl ?? AppData.shared.cuentosDestacados[0].titulo_español,
                                           fondo: AppData.shared.cuentosDestacados[1].imagen
                                       )
                                   }
                                   
                                   NavigationLink(
                                       destination: Cuentos(relato: AppData.shared.cuentosDestacados[2])
                                   ) {
                                       CuentoView(
                                           alto: CGFloat(150),
                                           titulo: AppData.shared.cuentosDestacados[0].titulo_nahuatl ?? AppData.shared.cuentosDestacados[0].titulo_español,
                                           fondo: AppData.shared.cuentosDestacados[2].imagen
                                       )
                                   }
                               }
                               .frame(maxWidth: .infinity)
                           }
                           .frame(maxWidth: .infinity)
                           
                           NavigationLink(
                               destination: Cuentos(relato: AppData.shared.cuentosDestacados[0])
                           ) {
                               CuentoView(
                                   alto: CGFloat(150),
                                   titulo: AppData.shared.cuentosDestacados[0].titulo_nahuatl ?? AppData.shared.cuentosDestacados[0].titulo_español,
                                   fondo: AppData.shared.cuentosDestacados[0].imagen
                               )
                           }
                           .frame(maxWidth: .infinity)
                           
                       } else {
                           Text("No hay suficientes cuentos destacados.")
                       }
                   }
                   .padding()
                   
               }
           }
           .background(
               ZStack{
                   Image("patron-light")
                       .resizable()
                       .scaledToFill()
               }
           )
       }
   }
}

#Preview {
   Aprende()
}
