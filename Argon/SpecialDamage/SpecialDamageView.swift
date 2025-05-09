//
//  SpecialDamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/12/24.
//

import SwiftUI

struct SpecialDamageView: View {
  @ObservedObject var matchModel: NewMatchModel
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?
  var playerIndex: Int
  var dismissCall: (() -> ())?

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .center) {
        if matchModel.hasCommanderDamage, let specialPresenter = specialDMGPresenter {
          VStack {
            Text("Commander Damage")
            CommanderDamageView(
              playerIndex: playerIndex,
              rotation: .degrees(360) - specialPresenter.1,
              matchModel: matchModel
            )
            .modifier(RotatedView(angle: specialPresenter.1))
          }
          Divider()
        }
        VStack {
          Text("Poison Damage")
          SmallDamageView(playerModel: matchModel.playerModels[playerIndex], dmgCount: $matchModel.playerModels[playerIndex].infectDMG)
        }
        .frame(minWidth: poisonWidth(model: matchModel, geom: geometry), minHeight: geometry.size.height/3, maxHeight: geometry.size.height/2)
      }
      .modifier(ModalCloseWrapper(title: "Special Damage", specialDMGPresenter: $specialDMGPresenter))
    }
    .getContrastColor(backgroundColor: .white)
  }

  func cmdrWidth(model: NewMatchModel, geom: GeometryProxy) -> CGFloat {
    if model.playerModels.count == 2 {
      return geom.size.width * 0.45
    } else {
      return geom.size.width * 0.6
    }
  }

  func poisonWidth(model: NewMatchModel, geom: GeometryProxy) -> CGFloat {
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
  @State static var specialDMGPresenter: (Int,Angle,Bool)?

  static var previews: some View {
    SpecialDamageView(matchModel: NewMatchModel(startingLife: 40, hasCommanderDamage: false, gameMode: .fourCorners), specialDMGPresenter: $specialDMGPresenter, playerIndex: 0)
  }
}
