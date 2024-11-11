//
//  WidgetTest.swift
//  WidgetTest
//
//  Created by Karla Tovar on 29/10/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), palabra: "Hola", traduccion: "Hello", significado: "Ejemplo de significado", imagen: Image("Gallo"), fondo: Image("patron-light"))
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let palabraEjemplo = palabras.first!
        return SimpleEntry(date: Date(), configuration: configuration, palabra: palabraEjemplo.nahuatl, traduccion: palabraEjemplo.español, significado: palabraEjemplo.significado ?? "", imagen: Image("Gallo"), fondo: Image("patron-light"))
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let currentDate = Date()

        // Crear entradas para cada palabra en el array `palabras`
        for (index, palabra) in palabras.enumerated() {
            let entryDate = Calendar.current.date(byAdding: .minute, value: index * 10, to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                configuration: configuration,
                palabra: palabra.nahuatl,
                traduccion: palabra.español,
                significado: palabra.significado ?? "",
                imagen: Image("Gallo"), // Puedes personalizar esta imagen para cada palabra si tienes más opciones
                fondo: Image("patron-light")
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let palabra: String
    let traduccion: String
    let significado: String
    let imagen: Image
    let fondo: Image
}

struct WidgetTestEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.fondo
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .clipped()

            entry.imagen
                .resizable()
                .scaledToFill()
                .position(x: 120 * 0.2, y: 120)
                .frame(width: 120, height: 120)
            
            VStack(alignment: .leading) {
                Text(entry.palabra)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(entry.traduccion)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(entry.significado)
                    .font(.caption2)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
            }
            .padding(10)
            .frame(width: 160, height: 160)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WidgetTest: Widget {
    let kind: String = "WidgetTest"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetTestEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    WidgetTest()
} timeline: {
    // Generar un array de entradas usando todas las palabras
    var entries: [SimpleEntry] = []
    
    // Asegúrate de que 'palabras' esté disponible en el contexto
    for palabra in palabras {
        let entry = SimpleEntry(
            date: .now,
            configuration: .smiley, // Puedes cambiar esto según tu lógica
            palabra: palabra.nahuatl,
            traduccion: palabra.español,
            significado: palabra.significado ?? "",
            imagen: Image("Gallo"),
            fondo: Image("patron-light") // Cambia según tu lógica de fondo
        )
        entries.append(entry)
    }

    // Retornar el array de entradas
    return entries
}


