//
//  ContentView.swift
//  Kachi
//
//  Created by CEDAM17 on 20/09/24.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            ProgressView(value: 10, total: 15)
        }
        .padding()
    }
}

#Preview {
    TimerView()
}
