//
//  PlayerCommanderDamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 9/17/24.
//

import SwiftUI

struct PlayerCommanderDamageView: View {
  var opponentIndex: Int
  @ObservedObject var playerModel: PlayerModel

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        HStack(spacing: 10) {
          ForEach(Array(playerModel.commanderDMG[playerModel.index].enumerated()), id: \.offset) { index, element in
            SmallDamageView(cmdrIndex: index, opponentIndex: opponentIndex, playerModel: playerModel, dmgCount: $playerModel.commanderDMG[opponentIndex][index])
          }
        }
      }
    }
    .padding(4)
  }
}

struct PlayerCommanderDamageView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerCommanderDamageView(opponentIndex: 0, playerModel: PlayerModel(index: 0, life: 40, numOfPlayers: 4))
  }
}
