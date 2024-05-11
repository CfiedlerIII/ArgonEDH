//
//  GeometryProxy+.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

extension GeometryProxy {
  func smallerDimension() -> CGFloat {
    if size.width < size.height {
      return size.width
    }
    return size.height
  }
}
