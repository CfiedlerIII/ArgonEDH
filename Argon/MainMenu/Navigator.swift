//
//  Navigator.swift
//  Argon
//
//  Created by Charles Fiedler on 5/10/24.
//

import SwiftUI

enum DisplayedView {
  case mainMenu
  case lifeTracker
}

struct Navigator: View {
  @State var displayedView: DisplayedView = .mainMenu

  var body: some View {
    switch displayedView {
    case .mainMenu:
      MainMenuView(navigator: self)
    case .lifeTracker:
      GameViewWrapper(navigator: self)
    }
  }
}

struct Navigator_Previews: PreviewProvider {
  static var previews: some View {
    Navigator()
  }
}
