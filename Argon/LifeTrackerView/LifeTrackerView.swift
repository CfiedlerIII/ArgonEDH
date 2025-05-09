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
  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  var body: some View {
    GeometryReader { geom in
      HStack(alignment: .center) {
        Spacer()
        Button(action: {
          if(isLongPressing){
            isLongPressing.toggle()
            holdTimer?.invalidate()
          } else {
            playerModel.adjustLife(value: -1)
            handleDeltaCounter(-1)
          }
        }, label: {
          VStack {
            Spacer()
            HStack {
              Spacer()
              Image(systemName: "minus")
                .resizable()
                .scaledToFit()
                .getContrastColor(backgroundColor: backgroundColor)
                .modifier(FitImageToLifeTracker(geom: geom))
              Spacer()
            }
            Spacer()
          }
        })
        .simultaneousGesture(
          LongPressGesture(
            minimumDuration: 0.2
          ).onEnded { _ in
            self.isLongPressing = true
            holdTimer = Timer.scheduledTimer(
              withTimeInterval: 0.1,
              repeats: true,
              block: { _ in
                playerModel.adjustLife(value: -1)
                handleDeltaCounter(-1)
              }
            )
          }
        )

        TrackerView(trackerType: .life, backgroundColor: backgroundColor, count: $playerModel.life)

        Button(action: {
          if(isLongPressing){
            isLongPressing.toggle()
            holdTimer?.invalidate()
          } else {
            playerModel.adjustLife(value: 1)
            handleDeltaCounter(1)
          }
        }, label: {
          VStack {
            Spacer()
            HStack {
              Spacer()
              Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .getContrastColor(backgroundColor: backgroundColor)
                .modifier(FitImageToLifeTracker(geom: geom))
              Spacer()
            }
            Spacer()
          }
        })
        .simultaneousGesture(
          LongPressGesture(
            minimumDuration: 0.2
          ).onEnded { _ in
            self.isLongPressing = true
            holdTimer = Timer.scheduledTimer(
              withTimeInterval: 0.1,
              repeats: true,
              block: { _ in
                playerModel.adjustLife(value: 1)
                handleDeltaCounter(1)
              }
            )
          }
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
        let newDelta = History.Delta(lifeDelta)
        history.deltas.append(newDelta)
      }
      lifeDelta = 0
    })
    lifeDelta = lifeDelta + value
  }
}

struct LifeTrackerView_Previews: PreviewProvider {
  @State static var count = 22
  @State static var delta = 2
  @State static var history = History()

  static var previews: some View {
    LifeTrackerView(playerModel: PlayerModel(index: 0, life: 40, numOfPlayers: 4), lifeDelta: $delta, history: $history)
  }
}

struct FitImageToLifeTracker: ViewModifier {
  var geom: GeometryProxy

  func body(content: Content) -> some View {
    content
      .frame(width: geom.smallerDimension() * 0.25, height: geom.smallerDimension() * 0.25)
  }
}
