//
//  GameSettingsView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/9/25.
//

import SwiftUI

struct GameSettingsView: View {
  var navigator: Navigator
  var matchModel: NewMatchModel
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
    .modifier(ModalCloseWrapper(title: "Game Settings", isDisplayed: $isDisplayed))
    .getContrastColor(backgroundColor: .white)
  }
}

#Preview {
  GameSettingsView(navigator: Navigator(), matchModel: NewMatchModel(gameMode: .twoPlayer), isDisplayed: .constant(true))
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
