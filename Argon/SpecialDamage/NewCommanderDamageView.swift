//
//  NewCommanderDamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

struct NewCommanderDamageView: View {
  var playerIndex: Int
  @ObservedObject var matchModel: NewMatchModel
  @Binding var isDisplayed: Bool

  var body: some View {
    GeometryReader { geometry in
      switch matchModel.gameMode {
      case .twoPlayer:
        VStack {
          PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
          PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
        }
      case .twoPlayerLandscape, .twoPlayerSameSide:
        HStack {
          PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
          PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
        }
      case .threeTPlayer:
          HStack {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
            VStack {
              PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
              PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
            }
          }
      case .threeLPlayer:
        HStack {
          VStack {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
            PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
          }
          VStack {
            PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
            Color.white
              .opacity(0.0)
              .modifier(MiniDamageSizeModifier())
          }
        }
      case .fourCorners:
        HStack {
          VStack {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
            PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
          }
          VStack {
            PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
            PlayerCommanderDamageView(opponentIndex: 3, playerModel: matchModel.playerModels[playerIndex])
          }
        }
      case .fourPlus:
        HStack {
          VStack {
            PlayerCommanderDamageView(opponentIndex: 0, playerModel: matchModel.playerModels[playerIndex])
          }
          VStack {
            PlayerCommanderDamageView(opponentIndex: 1, playerModel: matchModel.playerModels[playerIndex])
            PlayerCommanderDamageView(opponentIndex: 2, playerModel: matchModel.playerModels[playerIndex])
          }
          VStack {
            PlayerCommanderDamageView(opponentIndex: 3, playerModel: matchModel.playerModels[playerIndex])
          }
        }
      }
    }
    .background(.clear)
  }
}

#Preview {
  NewCommanderDamageView(playerIndex: 0, matchModel: NewMatchModel(startinglife: 40, gameMode: .threeTPlayer), isDisplayed: .constant(true))
}
