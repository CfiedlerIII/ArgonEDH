//
//  MenuModel.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//

class MenuModel {
  var gameMode: GameType
  var startingLife: Int
  var hasCMDDamage: Bool

  init(gameMode: GameType, startingLife: Int, hasCMDDamage: Bool = false) {
    self.gameMode = gameMode
    self.startingLife = startingLife
    self.hasCMDDamage = hasCMDDamage
  }
}
