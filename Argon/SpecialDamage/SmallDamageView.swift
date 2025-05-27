//
//  SmallDamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 9/17/24.
//

import SwiftUI

struct SmallDamageView: View {

  var backgroundColor: Color = .white
  var cmdrIndex: Int? = nil
  var opponentIndex: Int? = nil
  @ObservedObject var playerModel: PlayerModel
  @Binding var dmgCount: Int
  @State var lifeDelta: Int = 0
  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  var body: some View {
    GeometryReader { geom in
      ZStack {
        VStack {
          Divider()
            .frame(height: 2)
            .overlay(.black)
            .opacity(0.1)
        }

        Text("\(dmgCount)")
          .lineLimit(1)
          .font(.system(size: 500))
          .minimumScaleFactor(0.01)
          .getContrastColor(backgroundColor: backgroundColor)
          .modifier(MiniDamageSizeModifier(tweakedBy: 0.8))

        VStack {
          Rectangle()
            .fill(.clear)
            .contentShape(Rectangle())
            .gesture(
              TapGesture()
                .onEnded { value in
                  if(isLongPressing){
                    isLongPressing.toggle()
                    holdTimer?.invalidate()
                  } else {
                    if let cmdrIndex = cmdrIndex, let opponentIndex = opponentIndex {
                      playerModel.adjustCommanderDMG(value: 1, playerIndex: opponentIndex, cmdrIndex: cmdrIndex)
                      handleDeltaCounter(1)
                    }
                  }
                }
            )
            .simultaneousGesture(
              LongPressGesture(
                minimumDuration: 0.2
              ).onEnded { _ in
                self.isLongPressing = true
                holdTimer = Timer.scheduledTimer(
                  withTimeInterval: 0.1,
                  repeats: true,
                  block: { _ in
                    if let cmdrIndex = cmdrIndex, let opponentIndex = opponentIndex {
                      playerModel.adjustCommanderDMG(value: 1, playerIndex: opponentIndex, cmdrIndex: cmdrIndex)
                      handleDeltaCounter(1)
                    }
                  }
                )
              }
            )

          Rectangle()
            .fill(.clear)
            .contentShape(Rectangle())
            .gesture(
              TapGesture()
                .onEnded { value in
                  if(isLongPressing){
                    isLongPressing.toggle()
                    holdTimer?.invalidate()
                  } else {
                    if let cmdrIndex = cmdrIndex, let opponentIndex = opponentIndex {
                      playerModel.adjustCommanderDMG(value: -1, playerIndex: opponentIndex, cmdrIndex: cmdrIndex)
                      handleDeltaCounter(-1)
                    }
                  }
                }
            )
            .simultaneousGesture(
              LongPressGesture(
                minimumDuration: 0.2
              ).onEnded { _ in
                self.isLongPressing = true
                holdTimer = Timer.scheduledTimer(
                  withTimeInterval: 0.1,
                  repeats: true,
                  block: { _ in
                    if let cmdrIndex = cmdrIndex, let opponentIndex = opponentIndex {
                      playerModel.adjustCommanderDMG(value: -1, playerIndex: opponentIndex, cmdrIndex: cmdrIndex)
                      handleDeltaCounter(-1)
                    }
                  }
                )
              }
            )
        }
      }
      .background(backgroundColor)
      .clipShape(
        RoundedRectangle(
          cornerRadius: 20
        )
      )
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(.black, lineWidth: 3)
      )
    }
  }

  func handleDeltaCounter(_ value: Int) {
    deltaTimer?.invalidate()
    deltaTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
      if lifeDelta != 0 {
        playerModel.history.addDelta(value: lifeDelta)
      }
      lifeDelta = 0
    })
    lifeDelta = lifeDelta + value
  }
}

struct SmallDamageView_Previews: PreviewProvider {
  @ObservedObject static var playerModel = PlayerModel(index: 0, life: 40, numOfPlayers: 4)

  static var previews: some View {
    SmallDamageView(cmdrIndex: 0, opponentIndex: 0, playerModel: playerModel, dmgCount: $playerModel.commanderDMG[0][0])
  }
}
