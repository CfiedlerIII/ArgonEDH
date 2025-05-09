//
//  UniversalGameView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

enum GameMode: String, Codable {
  case twoPlayer
  case twoPlayerSameSide
  case twoPlayerLandscape
  case threeTPlayer
  case threeLPlayer
  case fourCorners
  case fourPlus

  func numOfPlayers() -> Int {
    switch self {
    case .twoPlayer, .twoPlayerLandscape, .twoPlayerSameSide:
      return 2
    case .threeTPlayer, .threeLPlayer:
      return 3
    case .fourCorners, .fourPlus:
      return 4
    }
  }

  func description() -> String {
    switch self {
    case .twoPlayer:
      "Portrait: Across from each other"
    case .twoPlayerLandscape:
      "Landscape: Across from each other"
    case .twoPlayerSameSide:
      "Landscape: Next to each other"
    case .threeTPlayer:
      "Landscape: In a 'T' layout"
    case .threeLPlayer:
      "Landscape: In an 'L' layout"
    case .fourCorners:
      "Landscape: In the four corners"
    case .fourPlus:
      "Landscape: In a plus configuration"
    }
  }

  static func getModesFor(players: Int) -> [GameMode] {
    switch players {
    case 2:
      return [.twoPlayer, .twoPlayerLandscape, .twoPlayerSameSide]
    case 3:
      return [.threeLPlayer, .threeTPlayer]
    default:
      return [.fourPlus, .fourCorners]
    }
  }
}

struct GameViewWrapper: View {
  var navigator: Navigator
  var gameMode: GameMode
  var startingLife: Int
  var hasCMDDMG: Bool

  var body: some View {
    GeometryReader { geom in
      ZStack {
        Color.black
          .ignoresSafeArea()
        UniversalGameView(navigator: navigator, matchModel: NewMatchModel(startinglife: startingLife, hasCommanderDamage: hasCMDDMG, gameMode: gameMode))
      }
    }
  }
}

struct UniversalGameView: View {
  var navigator: Navigator
  @ObservedObject var matchModel: NewMatchModel
  @State var specialDMGPresenter: (Int,Angle,Bool)? = nil
  @State var isDisplayingHistory: Bool = false

  var body: some View {
    GeometryReader { geom in
      ZStack {
        switch matchModel.gameMode {
        case .twoPlayer:
          VStack {
            PlayerView(backgroundColor: .green, rotation: .degrees(180.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            PlayerView(backgroundColor: .blue, rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
          }
        case .twoPlayerLandscape:
          HStack {
            PlayerView(backgroundColor: .green, rotation: .degrees(180.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            PlayerView(backgroundColor: .blue, rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
          }

        case .twoPlayerSameSide:
          HStack {
            PlayerView(backgroundColor: .green, rotation: .zero, matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            PlayerView(backgroundColor: .blue, rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
          }

        case .threeTPlayer:
          HStack {
            Spacer()
            PlayerView(backgroundColor: .green, rotation: .degrees(90.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
              .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
            Spacer()
            VStack {
              PlayerView(backgroundColor: .blue, rotation: .degrees(180), matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(backgroundColor: .yellow, rotation: .zero, matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .threeLPlayer:
          HStack {
            Spacer()
            VStack {
              PlayerView(backgroundColor: .green, rotation: .degrees(180), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(backgroundColor: .blue, rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(backgroundColor: .yellow, rotation: .degrees(180), matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              Color.black
            }
            Spacer()
          }

        case .fourCorners:
          HStack {
            Spacer()
            VStack {
              PlayerView(backgroundColor: .green, rotation: .degrees(180), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(backgroundColor: .blue, rotation: .degrees(0.0), matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(backgroundColor: .yellow, rotation: .degrees(180), matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(backgroundColor: .red, rotation: .zero, matchModel: matchModel, playerIndex: 3, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .fourPlus:
          HStack {
            Spacer()
            PlayerView(backgroundColor: .green, rotation: .degrees(90.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            Spacer()
            VStack {
              PlayerView(backgroundColor: .blue, rotation: .degrees(180), matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
              PlayerView(backgroundColor: .yellow, rotation: .zero, matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
            }
            Spacer()
            PlayerView(backgroundColor: .red, rotation: .degrees(270.0), matchModel: matchModel, playerIndex: 3, specialDMGPresenter: $specialDMGPresenter)
            Spacer()
          }
          .frame(width: geom.size.width, height: geom.size.height)
        }

        if let specialPresenter = specialDMGPresenter {
          if specialPresenter.2 {
            HistoryView(history: $matchModel.playerModels[specialPresenter.0].history, specialDMGPresenter: $specialDMGPresenter
            )
            .background(.white.opacity(0.95))
            .modifier(RotatedView(angle: specialPresenter.1))
          } else {
            SpecialDamageView(matchModel: matchModel, specialDMGPresenter: $specialDMGPresenter, playerIndex: specialPresenter.0, dismissCall: dismissSpecialDMGView
            )
            .background(.white.opacity(0.85))
            .modifier(RotatedView(angle: specialPresenter.1))
          }
        }
      }
    }
    .background(.black)
    .modifier(
      matchModel.gameMode == .twoPlayer ? LimitRotationTo(orientation: .portrait) : LimitRotationTo(orientation: .landscape)
    )
  }

  private func dismissSpecialDMGView() {
    self.specialDMGPresenter = nil
  }
}

struct UniversalGameView_Previews: PreviewProvider {
  static var previews: some View {
    UniversalGameView(navigator: Navigator(), matchModel: NewMatchModel(startinglife: 40, hasCommanderDamage: true, gameMode: .fourPlus))
  }
}
