//
//  PlayerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct PlayerView: View {

  var padding: CGFloat = 10
  var rotation: Angle
  var playerIndex: Int
  @ObservedObject var matchModel: GameModel
  @State var lifeDelta: Int = 0
  @State var isShowingHistory = false
  @State var isShowingPoison = false
  @State var isShowingSpecialDMG = false
  @State var isChangingColor = false
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?

  init(rotation: Angle, matchModel: GameModel, playerIndex: Int, specialDMGPresenter: Binding<(Int, Angle,Bool)?>) {
    self.rotation = rotation
    self.matchModel = matchModel
    self.playerIndex = playerIndex
    self._specialDMGPresenter = specialDMGPresenter
  }

  var body: some View {
    GeometryReader { geom in
      VStack(alignment: .center, spacing: 0) {
        Text("\(lifeDelta)")
          .getContrastColor(backgroundColor: $matchModel.playerModels[playerIndex].backgroundColor.wrappedValue)
          .font(.system(size: 500))
          .minimumScaleFactor(0.01)
          .frame(maxHeight: geom.size.height * 0.10)
          .opacity(lifeDelta != 0 ? 1.0 : 0.0)
          .padding(.top, 12)

        if isShowingPoison {
          VStack {
            Text("Poison Damage")
            SmallDamageView(playerModel: matchModel.playerModels[playerIndex], dmgCount: $matchModel.playerModels[playerIndex].infectDMG)
          }
          .frame(width: geom.size.width/2, height: geom.size.height/2)
        } else if isChangingColor {
          PlayerColorView(backgroundColor: $matchModel.playerModels[playerIndex].backgroundColor, isChangingColor: $isChangingColor)
        } else {
          LifeTrackerView(
            backgroundColor: $matchModel.playerModels[playerIndex].backgroundColor.wrappedValue,
            playerModel: matchModel.playerModels[playerIndex],
            lifeDelta: $lifeDelta,
            history: $matchModel.playerModels[playerIndex].history,
            isChangingColor: $isChangingColor
          )
          .frame(minHeight: geom.size.height * 0.4)
        }


        PlayerSettingsView(
          backgroundColor: $matchModel.playerModels[playerIndex].backgroundColor.wrappedValue,
          rotation: rotation,
          playerIndex: playerIndex,
          matchModel: matchModel,
          isShowingHistory: $isShowingHistory,
          isShowingPoison: $isShowingPoison,
          isShowingCommanderDMG: $isShowingSpecialDMG,
          history: $matchModel.playerModels[playerIndex].history, specialDMGPresenter: $specialDMGPresenter
        )
        .frame(maxHeight: geom.size.height * 0.25)
      }
      .padding(10)
    }
    .modifier(RotatedViewModifier(angle: rotation))
    .background($matchModel.playerModels[playerIndex].backgroundColor.wrappedValue)
    .cornerRadius(15)
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerView(rotation: .degrees(0.0), matchModel: GameModel(hasCommanderDamage: true, gameMode: .fourCorners), playerIndex: 0, specialDMGPresenter: .constant(nil))
  }
}
