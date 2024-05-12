//
//  LifeTrackerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct LifeTrackerView: View {

  @Binding var count: Int
  @Binding var lifeDelta: Int
  var backgroundColor: Color = .blue

  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  var body: some View {
    GeometryReader { geom in
      HStack(alignment: .center) {
        Spacer()
        Button(action: {
          if(isLongPressing){
            //this tap was caused by the end of a longpress gesture, so stop our fastforwarding
            isLongPressing.toggle()
            holdTimer?.invalidate()
          } else {
            count = count - 1
            handleDeltaCounter(-1)
          }
        }, label: {
          Image(systemName: "minus")
            .resizable()
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
            .modifier(FitImageToLifeTracker(geom: geom))
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
                count = count - 1
                handleDeltaCounter(-1)
              }
            )
          }
        )

        TrackerView(count: $count, trackerType: .life, backgroundColor: backgroundColor)

        Button(action: {
          if(isLongPressing){
            //this tap was caused by the end of a longpress gesture, so stop our fastforwarding
            isLongPressing.toggle()
            holdTimer?.invalidate()
          } else {
            count = count + 1
            handleDeltaCounter(1)
          }
        }, label: {
          Image(systemName: "plus")
            .resizable()
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
            .modifier(FitImageToLifeTracker(geom: geom))
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
                count = count + 1
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
//        let newDelta = History.Delta(lifeDelta)
//        history.deltas.append(newDelta)
      }
      lifeDelta = 0
    })
    lifeDelta = lifeDelta + value
  }
}

struct LifeTrackerView_Previews: PreviewProvider {
  @State static var count = 22
  @State static var delta = 2

  static var previews: some View {
    LifeTrackerView(count: $count, lifeDelta: $delta)
  }
}

struct FitImageToLifeTracker: ViewModifier {
  var geom: GeometryProxy

  func body(content: Content) -> some View {
    content
      .frame(width: geom.smallerDimension() * 0.25, height: geom.smallerDimension() * 0.25)
  }
}
