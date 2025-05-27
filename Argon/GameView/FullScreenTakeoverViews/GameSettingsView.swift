//
//  GameSettingsView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/9/25.
//

import SwiftUI

struct GameSettingsView: View {
  var navigator: Navigator
  var matchModel: GameModel
  @Binding var isDisplayed: Bool

  var body: some View {
    VStack {
      Button(action: {
        matchModel.resetMatch()
        isDisplayed = false
      }, label: {
        HStack {
          Image(systemName: "arrow.counterclockwise")
          Text("Reset Match")
        }
        .modifier(SettingsButtonStyle())
      })
      Button(action: {
        navigator.displayedView = .mainMenu
      }, label: {
        HStack {
          Image(systemName: "arrow.left")
          Text("Back to Menu")
        }
        .modifier(SettingsButtonStyle())
      })
      Spacer()
    }
    .modifier(ModalCloseModifier(title: "Game Settings", isDisplayed: $isDisplayed))
    .getContrastColor(backgroundColor: .white)
  }
}

struct SettingsButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(4)
      .background(Color(red: 0.85, green: 0.85, blue: 0.85))
      .clipShape(
        RoundedRectangle(cornerRadius: 6)
      )
  }
}

#Preview {
  GameSettingsView(navigator: Navigator(), matchModel: GameModel(gameMode: .twoPlayer), isDisplayed: .constant(true))
}


