//
//  PlayerSettingsView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct PlayerSettingsView: View {

  var backgroundColor: Color
  var rotation: Angle
  var playerIndex: Int
  @ObservedObject var matchModel: NewMatchModel
  @Binding var isShowingHistory: Bool
  @Binding var isShowingCommanderDMG: Bool
  @Binding var history: History
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?

  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 40) {
        Spacer()
        Button(action: {
          print("Commander Damage Pressed")
          isShowingCommanderDMG = true
          specialDMGPresenter = (playerIndex, rotation, false)
        }, label: {
          Image(systemName: "checkerboard.shield")
            .resizable()
            .font(.system(size: 500).weight(.ultraLight))
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
        })

        Button(action: {
          print("Life History Pressed")
          specialDMGPresenter = (playerIndex, rotation, true)
        }, label: {
          Image(systemName: "menucard")
            .resizable()
            .font(.system(size: 500).weight(.ultraLight))
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
        })
        Spacer()
      }
    }
    .padding(10)
    .background(backgroundColor)
  }
}

struct PlayerSettingsView_Previews: PreviewProvider {
  @State static var isShowingStuff = false
  @State static var history = History()
  @State static var specialDMG: (Int, Angle,Bool)? = nil

  static var previews: some View {
    PlayerSettingsView(
      backgroundColor: .blue,
      rotation: .zero, playerIndex: 0, matchModel: NewMatchModel(hasCommanderDamage: true, gameMode: .fourCorners),
      isShowingHistory: $isShowingStuff,
      isShowingCommanderDMG: $isShowingStuff,
      history: $history, specialDMGPresenter: $specialDMG
    )
  }
}
