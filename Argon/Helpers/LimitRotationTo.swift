//
//  LimitRotationTo.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//

import SwiftUI

struct LimitRotationTo: ViewModifier {
  let orientation: UIInterfaceOrientationMask

  func body(content: Content) -> some View {
    content
      .onAppear {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        AppDelegate.orientationLock = orientation
      }
  }
}
