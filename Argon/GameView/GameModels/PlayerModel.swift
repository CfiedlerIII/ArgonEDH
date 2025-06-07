//
//  PlayerModel.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//

import SwiftUI

protocol DamageModelable {
  var damage: Int { get set }
}

struct CmdrDamageModel: DamageModelable {
  var damage: Int
  
  init(damage: Int = 0) {
    self.damage = damage
  }
}

struct InfectDamageModel: DamageModelable {
  var damage: Int

  init(damage: Int = 0) {
    self.damage = damage
  }
}

class PlayerModel: ObservableObject, Identifiable {
  var id: String
  var index: Int
  @Published var life: Int = 20
  @Published var infectDMG = InfectDamageModel()
  @Published var commanderDMG: [[CmdrDamageModel]] = []
  @Published var history: History = History()
  @Published var backgroundColor: Color

  init(id: String = UUID().uuidString, index: Int, life: Int, numOfPlayers: Int, backgroundColor: Color = .pink) {
    self.id = id
    self.index = index
    self.life = life
    var cmdrDMG: [[CmdrDamageModel]] = []
    for i in 0..<numOfPlayers {
      cmdrDMG.append([])
      cmdrDMG[i].append(CmdrDamageModel())
    }
    self.commanderDMG = cmdrDMG
    self.backgroundColor = backgroundColor
  }

  func addCommander(playerIndex: Int, withNickname nickname: String? = nil) {
    if commanderDMG[playerIndex].count < 2 {
      print("Adding new commander!")
      commanderDMG[playerIndex].append(CmdrDamageModel())
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
    infectDMG.damage += value
  }

  func adjustCommanderDMG(value: Int, playerIndex: Int, cmdrIndex: Int) {
    commanderDMG[playerIndex][cmdrIndex].damage += value
    self.adjustLife(value: -value)
  }

  func adjustLife(value: Int) {
    self.life = self.life + value
  }
}
