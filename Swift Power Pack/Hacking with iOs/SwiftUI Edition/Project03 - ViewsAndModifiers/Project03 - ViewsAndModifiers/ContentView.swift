//
//  ContentView.swift
//  Project03 - ViewsAndModifiers
//
//  Created by Arnaud Miguet on 29.11.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .makeProminent()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func makeProminent() -> some View {
        self.modifier(ProminentTitle())
    }
}
