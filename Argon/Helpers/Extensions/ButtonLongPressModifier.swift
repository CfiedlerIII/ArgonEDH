//
//  ButtonLongPressModifier.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

struct ButtonLongPressModifier: ViewModifier {
  @Binding var isLongPressing: Bool
  @Binding var holdTimer: Timer?
  var longPressCallBack: () -> ()

  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        LongPressGesture(
          minimumDuration: 0.2
        ).onEnded { _ in
          isLongPressing = true
          holdTimer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true,
            block: { _ in
              self.longPressCallBack()
            }
          )
        }
      )
  }
}
