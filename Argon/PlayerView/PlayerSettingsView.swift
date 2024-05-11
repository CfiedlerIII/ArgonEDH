//
//  PlayerSettingsView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct PlayerSettingsView: View {
  var backgroundColor: Color

  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 40) {
        Spacer()
        Button(action: {
          print("Special Damage Pressed")
        }, label: {
          Image(systemName: "checkerboard.shield")
            .resizable()
            .font(.system(size: 500).weight(.ultraLight))
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
        })
        Button(action: {
            print("Life History Pressed")
        }, label: {
          Image(systemName: "menucard")
            .resizable()
            .font(.system(size: 500).weight(.ultraLight))
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
        })
        Spacer()
      }
    }
    .padding(10)
    .background(backgroundColor)
  }
}

struct PlayerSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerSettingsView(backgroundColor: .blue)
  }
}
