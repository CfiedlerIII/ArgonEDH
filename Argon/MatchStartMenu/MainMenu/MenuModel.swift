//
//  MenuModel.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//

class MenuModel {
  var gameMode: GameMode
  var startingLife: Int
  var hasCMDDamage: Bool

  init(gameMode: GameMode, startingLife: Int, hasCMDDamage: Bool = false) {
    self.gameMode = gameMode
    self.startingLife = startingLife
    self.hasCMDDamage = hasCMDDamage
  }
}
