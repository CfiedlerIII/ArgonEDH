//
//  CommanderModels.swift
//  Argon
//
//  Created by Charles Fiedler on 5/22/24.
//  Sarah loves you <3
//

import Foundation

class PlayerModel: ObservableObject, Identifiable {
  var id: String
  var index: Int
  @Published var life: Int = 20
  @Published var infectDMG: Int = 0
  @Published var commanderDMG: [[Int]] = []
  @Published var history: History = History()

  init(id: String = UUID().uuidString, index: Int, life: Int, numOfPlayers: Int) {
    self.id = id
    self.index = index
    self.life = life
    self.infectDMG = 0
    var cmdrDMG: [[Int]] = []
    for i in 0..<numOfPlayers {
      cmdrDMG.append([])
      cmdrDMG[i].append(0)
    }
    self.commanderDMG = cmdrDMG
  }

  func addCommander(playerIndex: Int, withNickname nickname: String? = nil) {
    if commanderDMG[playerIndex].count < 2 {
      print("Adding new commander!")
      commanderDMG[playerIndex].append(0)
      print("New array: \(commanderDMG)")
    } else {
      print("Cannot add a third commander.")
    }

  }

  func attemptToRemoveCommander(playerIndex: Int, cmdrIndex: Int) {
    if commanderDMG[playerIndex].count > 1 {
      print("Removing Commander!")
      _ = commanderDMG[playerIndex].remove(at: cmdrIndex)
      print("New array: \(commanderDMG)")
    } else {
      print("No extra commanders to remove.")
    }
  }

  func adjustPoisonDMG(value: Int) {
    print("Adjusting Poison Damage: \(value)")
    infectDMG += value
    print("poisonDMG: \(infectDMG)")
  }

  func adjustCommanderDMG(value: Int, playerIndex: Int, cmdrIndex: Int) {
    print("Dealing Commander Damage: \(value)")
    commanderDMG[playerIndex][cmdrIndex] += value
    print("cmdrDMG: \(commanderDMG)")
    self.adjustLife(value: -value)
  }

  func adjustLife(value: Int) {
    print("Adjusting Life Total: \(value)")
    self.life = self.life + value
  }
}

class NewMatchModel: ObservableObject {
  @Published var playerModels: [PlayerModel]
  var gameMode: GameMode
  var startingLife: Int = 20
  var hasCommanderDamage: Bool

  init(playerModels: [PlayerModel], hasCommanderDamage: Bool, gameMode: GameMode) {
    self.playerModels = playerModels
    self.hasCommanderDamage = hasCommanderDamage
    self.gameMode = gameMode
  }

  init(startingLife: Int = 40, hasCommanderDamage: Bool = true, gameMode: GameMode) {
    self.gameMode = gameMode
    self.startingLife = startingLife
    self.hasCommanderDamage = hasCommanderDamage
    self.playerModels = NewMatchModel.setupMatch(gameMode: gameMode, startingLife: startingLife)
  }

  class func setupMatch(gameMode: GameMode, startingLife: Int) -> [PlayerModel] {
    var tempPlayerModels: [PlayerModel] = []
    // Generate all player models
    for index in 0..<gameMode.numOfPlayers() {
      let newPlayerModel = PlayerModel(index: index, life: startingLife, numOfPlayers: gameMode.numOfPlayers())
      tempPlayerModels.append(newPlayerModel)
    }
    return tempPlayerModels
  }

  func resetMatch() {
    self.playerModels = NewMatchModel.setupMatch(gameMode: gameMode, startingLife: startingLife)
  }
}
