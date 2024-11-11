//
//  Conversacion2.swift
//  KachiV
//
//  Created by Karla Tovar on 12/10/24.
//

import SwiftUI

struct Conversacion2: View {
    
    @State private var originalLanguage: String = "Español"
    @State private var targetLanguage: String = "Nahuatl"
    
    @State private var textWidth: CGFloat = 0 // Declaración de textWidth
    
    let originalText: String
    let translatedText: String
    
    @State private var isMicPressed: Bool = false

    let languages = ["Español", "Nahuatl", "Otomí", "Totonaco"]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack{
//                    Picker("Idioma Original", selection: $originalLanguage) {
//                        ForEach(languages, id: \.self) { language in
//                            Text(language).tag(language)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .accentColor(Color.azulMexicano)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(originalText)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(.rosaMexicano))
                        .font(.system(size: 16))
                        .bold()
                    
                    Divider()
                    
                    Text(translatedText)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(.azulMexicano))
                        .font(.system(size: 16))
                        .bold()
                }
                .fixedSize(horizontal: true, vertical: false)
    
                
//                VStack{
////                    Picker("Idioma Traducir", selection: $targetLanguage) {
////                        ForEach(languages, id: \.self) { language in
////                            Text(language).tag(language)
////                        }
////                    }
////                    .pickerStyle(MenuPickerStyle())
////                    .accentColor(Color.azulMexicano)
////                    .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    Text("Kuix ken tikaj?")
//                        .foregroundColor(Color(.azulMexicano))
//                        .font(.system(size: 16))
//                        .bold()
//                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .shadow(radius: 3)
            )
                
        }
    }
}


#Preview {
    Conversacion2(originalText: "Hola, cómo estás'", translatedText: "Kuix ken tikaj?")
}
