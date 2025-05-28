//
//  ImageModifier.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

extension Image {
  func imageSizeModifier(size: CGFloat) -> some View {
    self
      .imageScaleModifier()
      .frame(maxWidth: size, maxHeight: size)
  }

  func imageScaleModifier() -> some View {
    self
      .resizable()
      .scaledToFit()
  }
}
