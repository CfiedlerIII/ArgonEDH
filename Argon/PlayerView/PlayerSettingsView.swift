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
  @Binding var isShowingHistory: Bool
  @Binding var isShowingCMDR: Bool
  @Binding var history: History

  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 40) {
        Spacer()
        Button(action: {
          print("Special Damage Pressed")
          isShowingCMDR = true
        }, label: {
          Image(systemName: "checkerboard.shield")
            .resizable()
            .font(.system(size: 500).weight(.ultraLight))
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
        })
        .sheet(isPresented: $isShowingCMDR, content: {
          SpecialDamageView(isDisplayed: $isShowingCMDR)
            .modifier(RotatedView(angle: rotation))
        })

        Button(action: {
          print("Life History Pressed")
          isShowingHistory = true
        }, label: {
          Image(systemName: "menucard")
            .resizable()
            .font(.system(size: 500).weight(.ultraLight))
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
        })
        .sheet(isPresented: $isShowingHistory, content: {
          HistoryView(history: history, isDisplayed: $isShowingHistory)
            .modifier(RotatedView(angle: rotation))
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

  static var previews: some View {
    PlayerSettingsView(
      backgroundColor: .blue,
      rotation: .zero,
      isShowingHistory: $isShowingStuff,
      isShowingCMDR: $isShowingStuff,
      history: $history
    )
  }
}
