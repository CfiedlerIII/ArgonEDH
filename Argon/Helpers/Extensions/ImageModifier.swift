//
//  ImageModifier.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

extension Image {
  func imageModifier(size: CGFloat) -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(maxWidth: size, maxHeight: size)
  }
}
