//
//  View+.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

enum ImageContrastMode {
  case light, dark
}

extension View {
  func getImageContrastMode(backgroundColor: Color, reversed: Bool = false) -> ImageContrastMode {
    var r, g, b, a: CGFloat
    (r, g, b, a) = (0, 0, 0, 0)
    UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
    let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
    if reversed {
      return luminance < 0.6 ? .dark : .light
    }
    return luminance < 0.6 ? .light : .dark
  }

  func getContrastColor(backgroundColor: Color, reversed: Bool = false) -> some View {
    var r, g, b, a: CGFloat
    (r, g, b, a) = (0, 0, 0, 0)
    UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
    let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
    if reversed {
      return luminance < 0.6 ? self.foregroundColor(.black) : self.foregroundColor(.white)
    }
    return luminance < 0.6 ? self.foregroundColor(.white) : self.foregroundColor(.black)
  }

  func getContrastBackgroundColor(backgroundColor: Color, reversed: Bool = false) -> some View {
    var r, g, b, a: CGFloat
    (r, g, b, a) = (0, 0, 0, 0)
    UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
    let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
    if reversed {
      return luminance < 0.6 ? self.background(.white) : self.background(.black)
    }
    return luminance < 0.6 ? self.background(.black) : self.background(.white)
  }
}
