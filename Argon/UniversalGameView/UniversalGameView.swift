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
            PlayerView(count: 20, backgroundColor: .green, rotation: .degrees(180.0))
            PlayerView(count: 20, backgroundColor: .blue)
          }
        case .twoPlayerSideways:
          HStack {
            PlayerView(count: 20, backgroundColor: .green, rotation: .degrees(180.0))
            PlayerView(count: 20, backgroundColor: .blue)
          }

        case .threeTPlayer:
          HStack {
            Spacer()
            PlayerView(count: 20, backgroundColor: .green)
              .modifier(RotatedView(angle: .degrees(90.0)))
              .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
            Spacer()
            VStack {
              PlayerView(count: 20, backgroundColor: .blue, rotation: .degrees(180))
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(count: 20, backgroundColor: .yellow)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .threeLPlayer:
          HStack {
            Spacer()
            VStack {
              PlayerView(count: 20, backgroundColor: .green, rotation: .degrees(180))
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(count: 20, backgroundColor: .blue)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(count: 20, backgroundColor: .yellow, rotation: .degrees(180))
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              Color.black
            }
            Spacer()
          }

        case .fourCorners:
          HStack {
            Spacer()
            VStack {
              PlayerView(count: 20, backgroundColor: .green, rotation: .degrees(180))
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(count: 20, backgroundColor: .blue)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(count: 20, backgroundColor: .yellow, rotation: .degrees(180))
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(count: 20, backgroundColor: .red)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .fourPlus:
          HStack {
            Spacer()
            PlayerView(count: 20, backgroundColor: .green)
              .modifier(RotatedView(angle: .degrees(90.0)))
            Spacer()
            VStack {
              PlayerView(count: 20, backgroundColor: .blue, rotation: .degrees(180))
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
              PlayerView(count: 20, backgroundColor: .yellow)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
            }
            Spacer()
            PlayerView(count: 20, backgroundColor: .red)
              .modifier(RotatedView(angle: .degrees(270.0)))
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
    UniversalGameView(navigator: Navigator(), gameMode: .threeLPlayer)
  }
}
