//
//  Perfil.swift
//  KachiV
//
//  Created by CEDAM19 on 08/10/24.
//

import SwiftUI

import SwiftUI

struct Perfil: View {
    let dias = ["Dom", "Lun", "Mar", "Mier", "Jue", "Vie", "Sab"]

    var body: some View {
        ScrollView{
            VStack {
                ZStack(alignment: .top) {
                    Image("Pattern")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                    Image("Perfil")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .offset(y: 100)
                }
                
                Text("¡Mah Cualli tonalli!")
                    .padding(.top,50)
                    .font(.system(size: 24, weight: .bold))
                
                VStack {
                    HStack(spacing: 20){
                        Image("Union")
                        Text("Dias en racha")
                    }
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))

                    HStack(spacing: 20){
                        ForEach(dias, id: \.self) { dia in
                            VStack{
                                Image("Union")
                                    .foregroundColor(.white)
                                    .opacity(0.7)
                                Text(dia)
                                    .font(.system(size: 11))
                            }
                        }
                    }
                    .foregroundColor(.white)
                    
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .frame(height:120)
                .background(Color.amarilloMexicano)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                
                VStack{
                    HStack{
                        Text("Logros")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // Acción para el botón "Ver todo"
                        }) {
                            Text("Ver todo")
                                .font(.subheadline)
                                .foregroundColor(.blue) // Color del texto
                        }
                    }
                    Divider()
                        .padding(.top, 0)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    ScrollView(.horizontal){
                        HStack(spacing: 20){
                            ForEach(0..<5) { index in
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    
                    HStack{
                        Text("Repasa y mejora")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // Acción para el botón "Ver todo"
                        }) {
                            Text("Ver todo")
                                .font(.subheadline)
                                .foregroundColor(.blue) // Color del texto
                        }
                    }
                    
                    Divider()
                        .padding(.top, 0)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    HStack{
                        
                        CuadradoIcon(alto: CGFloat(160), ancho: CGFloat(170), titulo: "Relatos guardados", subtitulo: "Nahuatl - Español", colortexto: .white,background: .azulMexicano, icono: Image(systemName: "books.vertical"))
                        
                        
                        CuadradoIcon(alto: CGFloat(160), ancho: CGFloat(170), titulo: "Diccionario", subtitulo: "Nahuatl - Español", colortexto: .amarilloObscuro, background: .amarilloMexicano, icono: Image(systemName: "character.book.closed"))
                        
                    }.padding()
                    
                    Rectangle().fill(.clear).frame(height: 70)
                    
                }.padding()
                
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    Perfil()
}
