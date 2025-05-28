//
//  GameModeMenuView.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

struct GameModeMenuView: View {
  var navigator: Navigator
  var menuModel: MenuModel
  var numOfPlayers: Int
  
  var body: some View {
    NavigationStack {
      VStack {
        ForEach(GameType.getModesFor(players: numOfPlayers), id: \.self) { gameMode in
          Button(action: {
            navigator.displayedView = .lifeTracker(gameMode, menuModel.startingLife, menuModel.hasCMDDamage)
          }, label: {
            Text(gameMode.description())
              .font(.system(size: 500))
              .minimumScaleFactor(0.01)
              .modifier(MainMenuModifier())
          })
        }
      }
      .navigationTitle("Player Layout")
    }
  }
}

#Preview {
  GameModeMenuView(navigator: Navigator(), menuModel: .init(gameMode: .twoPlayer, startingLife: 25), numOfPlayers: 2)
}
