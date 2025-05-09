//
//  PlayerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct PlayerView: View {

  var backgroundColor: Color = .pink
  var padding: CGFloat = 10
  var rotation: Angle
  var playerIndex: Int
  @ObservedObject var matchModel: NewMatchModel
  @State var lifeDelta: Int = 0
  @State var isShowingHistory = false
  @State var isShowingSpecialDMG = false
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?

  init(backgroundColor: Color, rotation: Angle, matchModel: NewMatchModel, playerIndex: Int, specialDMGPresenter: Binding<(Int, Angle,Bool)?>) {
    self.backgroundColor = backgroundColor
    self.rotation = rotation
    self.matchModel = matchModel
    self.playerIndex = playerIndex
    self._specialDMGPresenter = specialDMGPresenter
  }

  var body: some View {
    GeometryReader { geom in
      VStack(alignment: .center, spacing: 0) {
        Text("\(lifeDelta)")
          .getContrastColor(backgroundColor: backgroundColor)
          .font(.system(size: 500))
          .minimumScaleFactor(0.01)
          .frame(maxHeight: geom.size.height * 0.10)
          .opacity(lifeDelta != 0 ? 1.0 : 0.0)
          .padding(.top, 12)

        LifeTrackerView(
          backgroundColor: backgroundColor,
          playerModel: matchModel.playerModels[playerIndex],
          lifeDelta: $lifeDelta,
          history: $matchModel.playerModels[playerIndex].history
        )
        .frame(minHeight: geom.size.height * 0.4)

        PlayerSettingsView(
          backgroundColor: backgroundColor,
          rotation: rotation, 
          playerIndex: playerIndex,
          matchModel: matchModel,
          isShowingHistory: $isShowingHistory,
          isShowingCommanderDMG: $isShowingSpecialDMG,
          history: $matchModel.playerModels[playerIndex].history, specialDMGPresenter: $specialDMGPresenter
        )
        .frame(maxHeight: geom.size.height * 0.25)
      }
      .padding(10)
    }
    .modifier(RotatedView(angle: rotation))
    .background(backgroundColor)
    .cornerRadius(15)
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerView(backgroundColor: .green, rotation: .degrees(0.0), matchModel: NewMatchModel(hasCommanderDamage: true, gameMode: .fourCorners), playerIndex: 0, specialDMGPresenter: .constant(nil))
  }
}
