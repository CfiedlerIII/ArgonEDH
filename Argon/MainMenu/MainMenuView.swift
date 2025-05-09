//
//  MainMenuView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/10/24.
//

import SwiftUI

class MenuModel {
  var gameMode: GameMode
  var startingLife: Int
  var hasCMDDamage: Bool

  init(gameMode: GameMode, startingLife: Int, hasCMDDamage: Bool = false) {
    self.gameMode = gameMode
    self.startingLife = startingLife
    self.hasCMDDamage = hasCMDDamage
  }
}

struct MainMenuView: View {
  @Environment(\.colorScheme) var colorScheme
  var navigator: Navigator

  var body: some View {
    NavigationStack {
      VStack {
        Button(action: {
          navigator.displayedView = .lifeTracker(.twoPlayer,20,false)
        }, label: {
          Text("1v1")
            .font(.system(size: 500))
            .minimumScaleFactor(0.01)
        })
        .modifier(MainMenuModifier())

        NavigationLink(destination: {
          PlayerNumberMenuView(navigator: navigator, menuModel: MenuModel(gameMode: .fourCorners, startingLife: 40, hasCMDDamage: true))
        }, label: {
          Text("EDH/Commander")
            .font(.system(size: 500))
            .minimumScaleFactor(0.01)
        })
        .modifier(MainMenuModifier())

        Button(action: {
          navigator.displayedView = .lifeTracker(.twoPlayer,25,false)
        }, label: {
          Text("Brawl")
            .font(.system(size: 500))
            .minimumScaleFactor(0.01)
        })
        .modifier(MainMenuModifier())
      }
      .navigationTitle("Game Mode")
    }
    .ignoresSafeArea()
    .modifier(LimitRotationTo(orientation: .portrait))
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    MainMenuView(navigator: Navigator())
  }
}

struct MainMenuModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundStyle(.blue)
      .frame(height: 40)
      .padding()
      .clipShape(
        RoundedRectangle(
          cornerRadius: 20
        )
      )
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(.blue, lineWidth: 3)
      )
  }
}
