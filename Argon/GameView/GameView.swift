//
//  UniversalGameView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct GameView: View {
  var navigator: Navigator
  @ObservedObject var matchModel: GameModel
  @State var specialDMGPresenter: (Int,Angle,Bool)? = nil
  @State var isDisplayingHistory: Bool = false
  @State var isSettingsDisplayed: Bool = false

  var body: some View {
    GeometryReader { geom in
      ZStack {
        Color.black
          .ignoresSafeArea()
        switch matchModel.gameMode {
        case .twoPlayer:
          VStack {
            PlayerView(rotation: .degrees(180.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
          }
        case .twoPlayerLandscape:
          HStack {
            PlayerView(rotation: .degrees(180.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
          }

        case .twoPlayerSameSide:
          HStack {
            PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
          }

        case .threeTPlayer:
          HStack {
            Spacer()
            PlayerView(rotation: .degrees(90.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
              .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
            Spacer()
            VStack {
              PlayerView(rotation: .degrees(180), matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
              PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .threeLPlayer:
          HStack {
            Spacer()
            VStack {
              PlayerView(rotation: .degrees(180), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(rotation: .degrees(180), matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              Color.black
            }
            Spacer()
          }

        case .fourCorners:
          HStack {
            Spacer()
            VStack {
              PlayerView(rotation: .degrees(180), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(rotation: .degrees(0.0), matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
            VStack {
              PlayerView(rotation: .degrees(180), matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
              PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 3, specialDMGPresenter: $specialDMGPresenter)
                .frame(maxWidth: geom.size.width * 0.5, maxHeight: geom.size.height * 0.5)
            }
            Spacer()
          }

        case .fourPlus:
          HStack {
            Spacer()
            PlayerView(rotation: .degrees(90.0), matchModel: matchModel, playerIndex: 0, specialDMGPresenter: $specialDMGPresenter)
            Spacer()
            VStack {
              PlayerView(rotation: .degrees(180), matchModel: matchModel, playerIndex: 1, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
              PlayerView(rotation: .zero, matchModel: matchModel, playerIndex: 2, specialDMGPresenter: $specialDMGPresenter)
                .frame(width: geom.size.width * 0.49, height: geom.size.height * 0.49)
            }
            Spacer()
            PlayerView(rotation: .degrees(270.0), matchModel: matchModel, playerIndex: 3, specialDMGPresenter: $specialDMGPresenter)
            Spacer()
          }
          .frame(width: geom.size.width, height: geom.size.height)
        }

        Button(action: {
          isSettingsDisplayed = true
        }, label: {
          Image(systemName: "gearshape.circle")
            .resizable()
            .scaledToFit()
            .frame(width: 48, height: 48)
        })
        .foregroundStyle(.black)
        .padding(2)
        .background(.white)
        .clipShape(
          Circle()
        )
        if isSettingsDisplayed {
          GameSettingsView(navigator: self.navigator, matchModel: matchModel, isDisplayed: $isSettingsDisplayed)
            .background(.white.opacity(0.95))
        }

        if let specialPresenter = specialDMGPresenter {
          if specialPresenter.2 {
            HistoryView(history: $matchModel.playerModels[specialPresenter.0].history, specialDMGPresenter: $specialDMGPresenter
            )
            .background(.white.opacity(0.95))
            .modifier(RotatedViewModifier(angle: specialPresenter.1))
          } else {
            CommanderWrapperView(matchModel: matchModel, specialDMGPresenter: $specialDMGPresenter, playerIndex: specialPresenter.0, dismissCall: dismissSpecialDMGView
            )
            .background(.white.opacity(0.85))
            .modifier(RotatedViewModifier(angle: specialPresenter.1))
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
    GameView(navigator: Navigator(), matchModel: GameModel(startingLife: 40, hasCommanderDamage: true, gameMode: .fourPlus))
  }
}
