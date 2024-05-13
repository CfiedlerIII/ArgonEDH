//
//  UniversalGameView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

enum GameMode {
  case twoPlayer
  case twoPlayerSideways
  case threeTPlayer
  case threeLPlayer
  case fourCorners
  case fourPlus
}

struct GameViewWrapper: View {
  var navigator: Navigator

  var body: some View {
    GeometryReader { geom in
      ZStack {
        Color.black
          .ignoresSafeArea()
        UniversalGameView(navigator: navigator, gameMode: .fourCorners)
      }
    }
  }
}

struct UniversalGameView: View {
  var navigator: Navigator
  var gameMode: GameMode

  var body: some View {
    GeometryReader { geom in
      ZStack {
        switch gameMode {
        case .twoPlayer:
          VStack {
            PlayerView(backgroundColor: .green, rotation: .degrees(180.0), count: 20)
            PlayerView(backgroundColor: .blue, rotation: .zero, count: 20)
          }
        case .twoPlayerSideways:
          HStack {
            PlayerView(backgroundColor: .green, rotation: .degrees(180.0), count: 20)
            PlayerView(backgroundColor: .blue, rotation: .zero, count: 20)
          }

        case .threeTPlayer:
          HStack {
            Spacer()
            PlayerView(backgroundColor: .green, rotation: .degrees(90.0), count: 20)
              .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
            Spacer()
            VStack {
              PlayerView(backgroundColor: .blue, rotation: .degrees(180), count: 20)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(backgroundColor: .yellow, rotation: .zero, count: 20)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .threeLPlayer:
          HStack {
            Spacer()
            VStack {
              PlayerView(backgroundColor: .green, rotation: .degrees(180), count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(backgroundColor: .blue, rotation: .zero, count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(backgroundColor: .yellow, rotation: .degrees(180), count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              Color.black
            }
            Spacer()
          }

        case .fourCorners:
          HStack {
            Spacer()
            VStack {
              PlayerView(backgroundColor: .green, rotation: .degrees(180), count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(backgroundColor: .blue, rotation: .degrees(0.0), count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(backgroundColor: .yellow, rotation: .degrees(180), count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(backgroundColor: .red, rotation: .zero, count: 20)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .fourPlus:
          HStack {
            Spacer()
            PlayerView(backgroundColor: .green, rotation: .degrees(90.0), count: 20)
            Spacer()
            VStack {
              PlayerView(backgroundColor: .blue, rotation: .degrees(180), count: 20)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
              PlayerView(backgroundColor: .yellow, rotation: .zero, count: 20)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
            }
            Spacer()
            PlayerView(backgroundColor: .red, rotation: .degrees(270.0), count: 20)
            Spacer()
          }
          .frame(width: geom.size.width, height: geom.size.height)
        }
      }
    }
    .background(.black)
    .modifier(
      gameMode == .twoPlayer ? LimitRotationTo(orientation: .portrait) : LimitRotationTo(orientation: .landscape)
    )
  }
}

struct UniversalGameView_Previews: PreviewProvider {
  static var previews: some View {
    UniversalGameView(navigator: Navigator(), gameMode: .threeTPlayer)
  }
}
