//
//  LongPressViewModifier.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//

import SwiftUI

struct LongPressViewModifier: ViewModifier {
  @Binding var isLongPressing: Bool
  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  var longPressAction: () -> Void

  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        LongPressGesture(
          minimumDuration: 0.2
        ).onEnded { _ in
          self.isLongPressing = true
          longPressAction()
        }
      )
  }
}
