//
//  InfectCounterView.swift
//  Argon
//
//  Created by Charles Fiedler on 9/16/24.
//

import SwiftUI

struct InfectCounterView: View {

  var backgroundColor: Color = .white
  @ObservedObject var playerModel: PlayerModel
  @State var deltaTimer: Timer? = nil
  @State var holdTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  var body: some View {
    GeometryReader { geom in
      HStack {
        Spacer()
        VStack {
          Button(action: {
            if(isLongPressing){
              isLongPressing.toggle()
              holdTimer?.invalidate()
            } else {
              playerModel.adjustPoisonDMG(value: 1)
            }
          }, label: {
            Image(systemName: "plus")
              .resizable()
              .font(.system(size: 500).weight(.light))
              .scaledToFit()
              .getContrastColor(backgroundColor: backgroundColor)
              .padding()
          })
          .frame(width: geom.size.height/5, height: geom.size.height/5)
          .simultaneousGesture(
            LongPressGesture(
              minimumDuration: 0.2
            ).onEnded { _ in
              self.isLongPressing = true
              holdTimer = Timer.scheduledTimer(
                withTimeInterval: 0.1,
                repeats: true,
                block: { _ in
                  playerModel.adjustPoisonDMG(value: 1)
                }
              )
            }
          )

          Text("\(playerModel.infectDMG)")
            .lineLimit(1)
            .font(.system(size: 500))
            .minimumScaleFactor(0.01)
            .frame(width: geom.size.height/4, height: geom.size.height/4)

          Button(action: {
            if(isLongPressing){
              isLongPressing.toggle()
              holdTimer?.invalidate()
            } else {
              playerModel.adjustPoisonDMG(value: -1)
            }
          }, label: {
            Image(systemName: "minus")
              .resizable()
              .font(.system(size: 500).weight(.light))
              .scaledToFit()
              .getContrastColor(backgroundColor: backgroundColor)
              .padding()
          })
          .frame(width: geom.size.height/5, height: geom.size.height/5)
          .simultaneousGesture(
            LongPressGesture(
              minimumDuration: 0.2
            ).onEnded { _ in
              self.isLongPressing = true
              holdTimer = Timer.scheduledTimer(
                withTimeInterval: 0.1,
                repeats: true,
                block: { _ in
                  playerModel.adjustPoisonDMG(value: -1)
                }
              )
            }
          )
        }
        Spacer()
      }
      .background(backgroundColor)
      .clipShape(
        RoundedRectangle(
          cornerRadius: 20
        )
      )
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(.black, lineWidth: 3)
      )
    }
  }
}

struct InfectCounterView_Previews: PreviewProvider {
  @ObservedObject static var model = PlayerModel(index: 0, life: 40, numOfPlayers: 4)

  static var previews: some View {
    InfectCounterView(backgroundColor: .white, playerModel: model)
  }
}
