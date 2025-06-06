//
//  CommanderDamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/17/24.
//

import SwiftUI

struct CommanderDamageView: View {
  var playerIndex: Int
  var rotation: Angle = .zero
  @ObservedObject var matchModel: GameModel

  var body: some View {
    GeometryReader { geom in
      switch matchModel.gameMode {
      case .twoPlayer:
        VStack(spacing: 0) {
          PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
            .modifier(RotatedViewModifier(angle: rotation))
          PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
            .modifier(RotatedViewModifier(angle: rotation))
        }
      case .twoPlayerLandscape, .twoPlayerSameSide:
        HStack(spacing: 0) {
          PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
            .modifier(RotatedViewModifier(angle: rotation))
          PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
            .modifier(RotatedViewModifier(angle: rotation))
        }
      case .threeTPlayer:
          HStack(spacing: 0) {
            if playerIndex == 0 {
              VStack(spacing: 0) {
                PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
                  .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
                  .modifier(RotatedViewModifier(angle: rotation))
                PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
                  .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
                  .modifier(RotatedViewModifier(angle: rotation))
              }
              PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
                .frame(width: geom.size.height * 0.5, height: geom.size.width * 0.5)
                .modifier(RotatedViewModifier(angle: rotation))
            } else {
              PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
                .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
                .modifier(RotatedViewModifier(angle: rotation))
              VStack(spacing: 0) {
                PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
                  .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
                  .modifier(RotatedViewModifier(angle: rotation))
                PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
                  .frame(width: geom.size.width * 0.5, height: geom.size.height * 0.5)
                  .modifier(RotatedViewModifier(angle: rotation))
              }
            }
          }
      case .threeLPlayer:
        HStack(spacing: 0) {
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
            PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
          }
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
            Color.white
              .opacity(0.0)
              .modifier(MiniDamageSizeModifier())
          }
        }
      case .fourCorners:
        HStack(spacing: 0) {
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
            PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
          }
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
            PlayerCommanderDamageView(opponentIndex: 3, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
          }
        }
      case .fourPlus:
        HStack(spacing: 0) {
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
          }
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
            PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
          }
          VStack(spacing: 0) {
            PlayerCommanderDamageView(opponentIndex: 3, playerModel: matchModel.playerModels[playerIndex])
              .modifier(RotatedViewModifier(angle: rotation))
          }
        }
      }
    }
    .background(.clear)
  }
}

struct CommanderDamageView_Previews: PreviewProvider {
  static var gameMode: GameType = .threeTPlayer

  static var previews: some View {
    CommanderDamageView(playerIndex: 0, rotation: .init(degrees: 90.0), matchModel: GameModel(startingLife: 40, gameMode: gameMode))
  }
}

struct MiniDamageSizeModifier: ViewModifier {
  var tweakedBy: CGFloat = 1.0

  func body(content: Content) -> some View {
    GeometryReader { geom in
      VStack {
        Spacer()
        HStack {
          Spacer()
          content.frame(maxWidth: geom.smallerDimension() * tweakedBy, maxHeight: geom.smallerDimension() * tweakedBy)
          Spacer()
        }
        Spacer()
      }
    }
  }
}
