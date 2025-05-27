//
//  LifeTrackerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct LifeTrackerView: View {

  var backgroundColor: Color = .blue
  @ObservedObject var playerModel: PlayerModel
  @Binding var lifeDelta: Int
  @Binding var history: History
  @Binding var isChangingColor: Bool
  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  var body: some View {
    GeometryReader { geom in
      HStack(alignment: .center) {
        Spacer()
        ButtonImageView(
          holdTimer: $holdTimer,
          isLongPressing: $isLongPressing,
          systemName: "minus",
          buttonTapAction: {
            if(isLongPressing){
              isLongPressing.toggle()
              holdTimer?.invalidate()
            } else {
              playerModel.adjustLife(value: -1)
              handleDeltaCounter(-1)
            }
          },
          buttonHoldAction: {
            playerModel.adjustLife(value: -1)
            handleDeltaCounter(-1)
          },
          backgroundColor: backgroundColor
        )

        TrackerView(trackerType: .life, backgroundColor: backgroundColor, count: $playerModel.life)
          .frame(width: geom.size.width * 0.5, height: geom.size.height)
          .onTapGesture {
            isChangingColor = true
          }

        ButtonImageView(
          holdTimer: $holdTimer,
          isLongPressing: $isLongPressing,
          systemName: "plus",
          buttonTapAction: {
            if(isLongPressing){
              isLongPressing.toggle()
              holdTimer?.invalidate()
            } else {
              playerModel.adjustLife(value: 1)
              handleDeltaCounter(1)
            }
          },
          buttonHoldAction: {
            playerModel.adjustLife(value: 1)
            handleDeltaCounter(1)
          },
          backgroundColor: backgroundColor
        )
        Spacer()
      }
    }
    .background(backgroundColor)
  }

  func handleDeltaCounter(_ value: Int) {
    deltaTimer?.invalidate()
    deltaTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
      if lifeDelta != 0 {
        history.addDelta(value: lifeDelta)
      }
      lifeDelta = 0
    })
    lifeDelta = lifeDelta + value
  }
}

struct FitImageToLifeTracker: ViewModifier {
  var geom: GeometryProxy

  func body(content: Content) -> some View {
    content
      .frame(width: geom.smallerDimension() * 0.25, height: geom.smallerDimension() * 0.25)
  }
}

struct LifeTrackerView_Previews: PreviewProvider {
  @State static var count = 22
  @State static var delta = 2
  @State static var history = History()

  static var previews: some View {
    LifeTrackerView(playerModel: PlayerModel(index: 0, life: 40, numOfPlayers: 4), lifeDelta: $delta, history: $history, isChangingColor: .constant(false))
  }
}
