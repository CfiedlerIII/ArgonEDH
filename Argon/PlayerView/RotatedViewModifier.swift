//
//  RotatedView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/8/24.
//

import SwiftUI

struct RotatedViewModifier: ViewModifier {
  let angle: Angle

  func body(content: Content) -> some View {
    GeometryReader { geom in
      VStack {
        content
          .frame(width: angle.degrees == 90.0 || angle.degrees == 270.0 ? geom.size.height : geom.size.width, height: angle.degrees == 90.0 || angle.degrees == 270.0 ? geom.size.width : geom.size.height)
          .rotationEffect(angle)
      }
      .frame(width: geom.size.width, height: geom.size.height)
    }
  }
}
