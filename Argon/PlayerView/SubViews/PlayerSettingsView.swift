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
  @ObservedObject var matchModel: GameModel
  @Binding var isShowingHistory: Bool
  @Binding var isShowingPoison: Bool
  @Binding var isShowingCommanderDMG: Bool
  @Binding var history: History
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?

  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 40) {
        Spacer()
        if matchModel.hasCommanderDamage {
          Button(action: {
            isShowingHistory = false
            isShowingPoison = false
            isShowingCommanderDMG.toggle()
            specialDMGPresenter = (playerIndex, rotation, false)
          }, label: {
            Image(systemName: "checkerboard.shield")
              .imageScaleModifier()
              .font(.system(size: 500).weight(.ultraLight))
              .getContrastColor(backgroundColor: backgroundColor)
              .fontWeight(isShowingCommanderDMG ? .bold : .regular)
          })
        }

        Button(action: {
          isShowingHistory = false
          isShowingPoison.toggle()
          isShowingCommanderDMG = false
        }, label: {
          ZStack {
            Image(systemName: "drop")
              .imageScaleModifier()
              .font(.system(size: 500).weight(.ultraLight))
              .getContrastColor(backgroundColor: backgroundColor)
              .fontWeight(isShowingPoison ? .bold : .regular)
            Image(getImageContrastMode(backgroundColor: backgroundColor) == .light ? "skull.light.fill" : "skull.dark.fill")
              .imageScaleModifier()
              .font(.system(size: 500).weight(.medium))
              .getContrastColor(backgroundColor: backgroundColor)
              .frame(width: geometry.size.height/3)
              .padding(.top,geometry.size.height/4)
          }
        })

        Button(action: {
          isShowingHistory.toggle()
          isShowingPoison = false
          isShowingCommanderDMG = false
          specialDMGPresenter = (playerIndex, rotation, true)
        }, label: {
          Image(systemName: "menucard")
            .imageScaleModifier()
            .font(.system(size: 500).weight(.ultraLight))
            .getContrastColor(backgroundColor: backgroundColor)
            .fontWeight(isShowingHistory ? .bold : .regular)
        })
        Spacer()
      }
    }
    .padding(10)
    .background(backgroundColor)
  }
}

struct PlayerSettingsView_Previews: PreviewProvider {
  @State static var isShowingHistory = false
  @State static var isShowingPoison = false
  @State static var isShowingCommanderDMG = false
  @State static var history = History()
  @State static var specialDMG: (Int, Angle,Bool)? = nil

  static var previews: some View {
    PlayerSettingsView(
      backgroundColor: .blue,
      rotation: .zero, playerIndex: 0, matchModel: GameModel(hasCommanderDamage: true, gameMode: .fourCorners),
      isShowingHistory: $isShowingHistory,
      isShowingPoison: $isShowingPoison,
      isShowingCommanderDMG: $isShowingCommanderDMG,
      history: $history, specialDMGPresenter: $specialDMG
    )
  }
}
