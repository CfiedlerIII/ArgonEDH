//
//  Navigator.swift
//  Argon
//
//  Created by Charles Fiedler on 5/10/24.
//

import SwiftUI

enum DisplayedView {
  case mainMenu
  case lifeTracker(GameMode,Int,Bool)
}

struct Navigator: View {
  @State var displayedView: DisplayedView = .mainMenu

  var body: some View {
    switch displayedView {
    case .mainMenu:
      MainMenuView(navigator: self)
    case .lifeTracker(let gameMode, let startingLife, let hasCMDDMG):
      GameViewWrapper(navigator: self, gameMode: gameMode, startingLife: startingLife, hasCMDDMG: hasCMDDMG)
    }
  }
}

struct Navigator_Previews: PreviewProvider {
  static var previews: some View {
    Navigator()
  }
}
