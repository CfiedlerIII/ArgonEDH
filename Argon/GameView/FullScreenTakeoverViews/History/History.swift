//
//  History.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//


import SwiftUI

class History {
  var deltas: [Delta] = []

  init(deltas: [Delta] = []) {
    self.deltas = deltas
  }

  func addDelta(value: Int) {
    let newDelta = Delta(value)
    deltas.append(newDelta)
  }

  struct Delta: Identifiable {
    let id = UUID()
    var change: Int

    init(_ change: Int) {
      self.change = change
    }
  }
}
