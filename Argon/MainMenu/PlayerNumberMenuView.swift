//
//  PlayerNumberMenuView.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

struct PlayerNumberMenuView: View {
  var navigator: Navigator
  var menuModel: MenuModel

  var body: some View {
    NavigationStack {
      VStack {
        ForEach(2..<5) { numPlayers in
          NavigationLink(destination: {
            GameModeMenuView(navigator: navigator, menuModel: menuModel, numOfPlayers: numPlayers)
          }, label: {
            Text("\(numPlayers)")
              .font(.system(size: 500))
              .minimumScaleFactor(0.01)
              .modifier(MainMenuModifier())
          })
        }
      }
      .navigationTitle("Number of Players")
    }
  }
}

#Preview {
  PlayerNumberMenuView(navigator: Navigator(), menuModel: MenuModel(gameMode: .fourCorners, startingLife: 40))
}
