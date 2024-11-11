//
//  Home.swift
//  Kachi
//
//  Created by CEDAM17 on 08/10/24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var confLengua: ConfiguracionLengua

    // Diccionario de textos según idioma
    let saludoDia: [String: String] = [
        "español": "¡Buen día!",
        "nahuatl": "¡Mah cualli tonalli!",
        "otomi": "¡Ki hats'i!",
        "totonaco": "¡Kuinilh!"
    ]
    
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
                        
                        Text(Textos.obtenerTexto(idioma: confLengua.idiomaSeleccionado, clave: "saludo"))
                        .font(.title)
                        .fontWeight(.medium)
                        
                        Spacer()
                        
                        Picker("Idioma", selection: $confLengua.idiomaSeleccionado) {
                            Text("Náhuatl").tag("nahuatl")
                            Text("Español").tag("español")
                            Text("Otomí").tag("otomi")
                            Text("Totonaco").tag("totonaco")
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
                    
                    CardUsuario(
                        alto: CGFloat(220),
                        ancho: CGFloat(370),
                        titulo: "Curso 1: Lo Esencial",
                        subtitulo: "4/15",
                        progreso: 10,
                        racha: "14 días de racha",
                        colorTexto: .white,
                        background: .rosaMexicano,
                        iconoFondo: Image("fondo_card"),
                        iconoAvatar: Image("personaje")
                    )
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading){
                            Text("Relatos destacados")
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
                    
                    HStack {
                        if AppData.shared.cuentosDestacados.count >= 3 {
                            NavigationLink(
                                destination: Cuentos(relato: AppData.shared.cuentosDestacados[2])
                            ) {
                                CuentoView(
                                    alto: CGFloat(210),
                                    titulo: AppData.shared.cuentosDestacados[2].titulo_nahuatl ?? "Sin traducción",
                                    fondo: AppData.shared.cuentosDestacados[2].imagen
                                )
                                .frame(maxWidth: .infinity)
                            }
                            
                            VStack {
                                NavigationLink(
                                    destination: Cuentos(relato: AppData.shared.cuentosDestacados[0])
                                ) {
                                    CuentoView(
                                        alto: CGFloat(130),
                                        titulo: AppData.shared.cuentosDestacados[0].titulo_español,
                                        fondo: AppData.shared.cuentosDestacados[0].imagen
                                    )
                                }
                                
                                NavigationLink(
                                    destination: Cuentos(relato: AppData.shared.cuentosDestacados[1])
                                ) {
                                    CuentoView(
                                        alto: CGFloat(70),
                                        titulo: AppData.shared.cuentosDestacados[1].titulo_español,
                                        fondo: AppData.shared.cuentosDestacados[1].imagen
                                    )
                                }
                            }
                        } else {
                            Text("No hay suficientes cuentos destacados.")
                        }
                    }
                    .padding()
                    
                    
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
                    
                    
                    //                    VStack{
                    //                        ForEach(filteredStories) { cuento in
                    //                            CuentoView(
                    //                                alto: CGFloat(130),
                    //                                tituloEs: cuento.titulo_español,
                    //                                tituloLen: selectedLanguage == "Nahuatl" ? cuento.titulo_nahuatl ?? "" :
                    //                                    selectedLanguage == "Otomi" ? cuento.titulo_otomi ?? "" :
                    //                                    selectedLanguage == "Totonaco" ? cuento.titulo_totonaco ?? "" :
                    //                                    cuento.titulo_español,
                    //                                fondo: cuento.imagen
                    //                            )
                    //                        }
                    //                    }
                    //                    .padding()
                    
                    
                    VStack(alignment: .leading){
                        ForEach(appData.categorias) { categoria in
                            HStack {
                                Image(categoria.icono) // Asegúrate de que imageName es el nombre de la imagen que quieres usar
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24) // Ajusta el tamaño según tus necesidades
                                
                                Text(categoria.nombre.español)
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .padding(.top, 0)
                        .padding(.bottom, 0)
                        .background(.white.opacity(0.80))
                        .cornerRadius(20)
                    }
                    .padding()
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .cornerRadius(20)
                    
                    Rectangle().fill(.clear).frame(height: 50)
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
    let confLengua = ConfiguracionLengua()
    
    Home()
        .environmentObject(confLengua)
}
