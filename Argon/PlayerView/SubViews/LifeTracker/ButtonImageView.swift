//
//  ButtonImageView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//

import SwiftUI

struct ButtonImageView: View {
  @Binding var holdTimer: Timer?
  @Binding var isLongPressing: Bool
  var systemName: String
  var buttonTapAction: (() -> ())?
  var buttonHoldAction: (() -> ())?
  var backgroundColor: Color

  var body: some View {
    GeometryReader { geom in
      Button(action: {
        if(isLongPressing){
          isLongPressing.toggle()
          holdTimer?.invalidate()
        } else {
          buttonTapAction?()
        }
      }, label: {
        VStack {
          Spacer()
          HStack {
            Spacer()
            Image(systemName: systemName)
              .imageScaleModifier()
              .getContrastColor(backgroundColor: backgroundColor)
              .modifier(FitImageToLifeTracker(geom: geom))
            Spacer()
          }
          Spacer()
        }
      })
      .modifier(LongPressViewModifier(isLongPressing: $isLongPressing, longPressAction: {
        holdTimer = Timer.scheduledTimer(
          withTimeInterval: 0.1,
          repeats: true,
          block: { _ in
            buttonHoldAction?()
          }
        )
      }))
    }
  }
}
