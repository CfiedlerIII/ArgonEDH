//
//  CommanderModels.swift
//  Argon
//
//  Created by Charles Fiedler on 5/22/24.
//  Sarah loves you <3
//

import SwiftUI

class PlayerModel: ObservableObject, Identifiable {
  var id: String
  var index: Int
  @Published var life: Int = 20
  @Published var infectDMG: Int = 0
  @Published var commanderDMG: [[Int]] = []
  @Published var history: History = History()
  @Published var backgroundColor: Color

  init(id: String = UUID().uuidString, index: Int, life: Int, numOfPlayers: Int, backgroundColor: Color = .pink) {
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
    self.backgroundColor = backgroundColor
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
    infectDMG += value
  }

  func adjustCommanderDMG(value: Int, playerIndex: Int, cmdrIndex: Int) {
    commanderDMG[playerIndex][cmdrIndex] += value
    self.adjustLife(value: -value)
  }

  func adjustLife(value: Int) {
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
    self.playerModels = NewMatchModel.setupMatch(gameMode: gameMode, startingLife: startingLife)
  }
}
