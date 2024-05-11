//
//  MainMenuView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/10/24.
//

import SwiftUI

struct MainMenuView: View {
  var navigator: Navigator

  var body: some View {
    GeometryReader { geom in
      ZStack {
        Color.yellow
          .ignoresSafeArea()
        Button(action: {
          navigator.displayedView = .lifeTracker
        }, label: {
          Image(systemName: "arrow.up")
            .resizable()
            .aspectRatio(contentMode: .fit)
        })
      }
    }
    .modifier(LimitRotationTo(orientation: .all))
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    MainMenuView(navigator: Navigator())
  }
}
