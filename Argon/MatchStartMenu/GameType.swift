//
//  GameMode.swift
//  Argon
//
//  Created by Charles Fiedler on 5/27/25.
//


enum GameType: String, Codable {
  case twoPlayer
  case twoPlayerSameSide
  case twoPlayerLandscape
  case threeTPlayer
  case threeLPlayer
  case fourCorners
  case fourPlus

  func numOfPlayers() -> Int {
    switch self {
    case .twoPlayer, .twoPlayerLandscape, .twoPlayerSameSide:
      return 2
    case .threeTPlayer, .threeLPlayer:
      return 3
    case .fourCorners, .fourPlus:
      return 4
    }
  }

  func description() -> String {
    switch self {
    case .twoPlayer:
      "Portrait: Across from each other"
    case .twoPlayerLandscape:
      "Landscape: Across from each other"
    case .twoPlayerSameSide:
      "Landscape: Next to each other"
    case .threeTPlayer:
      "Landscape: In a 'T' layout"
    case .threeLPlayer:
      "Landscape: In an 'L' layout"
    case .fourCorners:
      "Landscape: In the four corners"
    case .fourPlus:
      "Landscape: In a plus configuration"
    }
  }

  static func getModesFor(players: Int) -> [GameType] {
    switch players {
    case 2:
      return [.twoPlayer, .twoPlayerLandscape, .twoPlayerSameSide]
    case 3:
      return [.threeLPlayer, .threeTPlayer]
    default:
      return [.fourPlus, .fourCorners]
    }
  }
}
