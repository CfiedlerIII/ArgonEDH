//
//  CommanderWrapperView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/12/24.
//

import SwiftUI

struct CommanderWrapperView: View {
  @ObservedObject var matchModel: GameModel
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?
  var playerIndex: Int
  var dismissCall: (() -> ())?

  var body: some View {
    GeometryReader { geometry in
      if let specialPresenter = specialDMGPresenter {
        VStack {
          CommanderDamageView(
            playerIndex: playerIndex,
            rotation: .degrees(360) - specialPresenter.1,
            matchModel: matchModel
          )
          .modifier(RotatedViewModifier(angle: specialPresenter.1))
        }
        .modifier(ModalCloseModifier(title: "Commander Damage", specialDMGPresenter: $specialDMGPresenter))
      }
    }
    .getContrastColor(backgroundColor: .white)
  }

  func cmdrWidth(model: GameModel, geom: GeometryProxy) -> CGFloat {
    if model.playerModels.count == 2 {
      return geom.size.width * 0.45
    } else {
      return geom.size.width * 0.6
    }
  }

  func poisonWidth(model: GameModel, geom: GeometryProxy) -> CGFloat {
    if matchModel.hasCommanderDamage {
      if model.playerModels.count == 2 {
        return geom.size.width * 0.45
      } else {
        return geom.size.width * 0.3
      }
    } else {
      return geom.size.width
    }
  }
}

struct SpecialDamageView_Previews: PreviewProvider {
  @State static var isDisplayed: Bool = false
  @State static var specialDMGPresenter: (Int,Angle,Bool)? = (40,Angle(degrees: 180.0),true)

  static var previews: some View {
    CommanderWrapperView(matchModel: GameModel(startingLife: 40, hasCommanderDamage: true, gameMode: .threeTPlayer), specialDMGPresenter: $specialDMGPresenter, playerIndex: 2)
  }
}
