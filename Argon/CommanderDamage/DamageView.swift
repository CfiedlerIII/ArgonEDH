//
//  DamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 3/5/25.
//

import SwiftUI

struct DamageView: View {

  var backgroundColor: Color = .white
  var cmdrIndex: Int? = nil
  var opponentIndex: Int? = nil
  @ObservedObject var playerModel: PlayerModel
  @Binding var dmgCount: Int
  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  var body: some View {
    GeometryReader { geom in
      HStack {
        Spacer()
        ZStack {
          VStack {
            Divider()
              .frame(height: 2)
              .overlay(.black)
          }

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
                      } else {
                        playerModel.adjustPoisonDMG(value: 1)
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
                      } else {
                        playerModel.adjustPoisonDMG(value: 1)
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
                      } else {
                        playerModel.adjustPoisonDMG(value: -1)
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
                      } else {
                        playerModel.adjustPoisonDMG(value: -1)
                      }
                    }
                  )
                }
              )
          }
        }
        Spacer()
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
}

struct DamageView_Previews: PreviewProvider {
  @ObservedObject static var playerModel = PlayerModel(index: 0, life: 40, numOfPlayers: 4)

  static var previews: some View {
    DamageView(cmdrIndex: 0, opponentIndex: 0, playerModel: playerModel, dmgCount: $playerModel.commanderDMG[0][0])
  }
}
