//
//  RotatedView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/8/24.
//

import SwiftUI

struct RotatedView: ViewModifier {
  let angle: Angle

  func body(content: Content) -> some View {
    GeometryReader { geom in
      VStack {
        content
          .frame(width: geom.size.height, height: geom.size.width)
          .rotationEffect(angle)
      }
      .frame(width: geom.size.width, height: geom.size.height)
    }
  }
}
