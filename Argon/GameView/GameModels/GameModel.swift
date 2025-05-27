//
//  GameModel.swift
//  Argon
//
//  Created by Charles Fiedler on 5/22/24.
//

import SwiftUI

class GameModel: ObservableObject {
  @Published var playerModels: [PlayerModel]
  var gameMode: GameType
  var startingLife: Int = 20
  var hasCommanderDamage: Bool

  init(playerModels: [PlayerModel], hasCommanderDamage: Bool, gameMode: GameType) {
    self.playerModels = playerModels
    self.hasCommanderDamage = hasCommanderDamage
    self.gameMode = gameMode
  }

  init(startingLife: Int = 40, hasCommanderDamage: Bool = true, gameMode: GameType) {
    self.gameMode = gameMode
    self.startingLife = startingLife
    self.hasCommanderDamage = hasCommanderDamage
    self.playerModels = GameModel.setupMatch(gameMode: gameMode, startingLife: startingLife)
  }

  class func setupMatch(gameMode: GameType, startingLife: Int) -> [PlayerModel] {
    let defaultColors: [Color] = [.green, .blue, .red, .yellow]
    var tempPlayerModels: [PlayerModel] = []
    // Generate all player models
    for index in 0..<gameMode.numOfPlayers() {
      let newPlayerModel = PlayerModel(index: index, life: startingLife, numOfPlayers: gameMode.numOfPlayers(), backgroundColor: defaultColors[index])
      tempPlayerModels.append(newPlayerModel)
    }
    return tempPlayerModels
  }

  func resetMatch() {
    self.playerModels = GameModel.setupMatch(gameMode: gameMode, startingLife: startingLife)
  }
}
