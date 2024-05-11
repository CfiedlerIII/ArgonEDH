//
//  ContentView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct ContentView: View {
  var backgroundColor: Color = .yellow

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
        .getContrastColor(backgroundColor: self.backgroundColor)
    }
    .padding()
    .background(self.backgroundColor)
  }
}

#Preview {
  ContentView()
}
