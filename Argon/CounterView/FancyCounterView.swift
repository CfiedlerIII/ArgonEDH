//
//  FancyCounterView.swift
//  Argon
//
//  Created by Charles Fiedler on 3/4/25.
//

import SwiftUI

struct FancyCounterView: View {
  @ObservedObject var model: CounterModel
  @Binding var backgroundColor: Color
  @State var plusTimer: Timer? = nil
  @State var minusTimer: Timer? = nil
  @State var isLongPressing: Bool = false

  static let textProportion = 0.8
  static let buttonProportion = 1.0 - textProportion

    var body: some View {
      GeometryReader { geom in
        switch model.orientation {
        case .vertical:
          ZStack {
            Text("\(model.count)")
              .font(.system(size: 500))
              .minimumScaleFactor(0.01)
              .frame(maxWidth: geom.size.height * FancyCounterView.textProportion, maxHeight: geom.size.height * FancyCounterView.textProportion)
            VStack {
              Button(action: {
                if(isLongPressing){
                  isLongPressing.toggle()
                  plusTimer?.invalidate()
                  plusTimer = nil
                } else {
                  model.modifyCount(1)
                }
              }, label: {
                Rectangle()
                  .frame(maxWidth: geom.size.width, maxHeight: geom.size.height/2)
                  .foregroundStyle(plusTimer != nil ? Color.gray.opacity(0.8) : Color.clear)
              })
              .modifier(
                ButtonLongPressModifier(
                  isLongPressing: $isLongPressing, holdTimer: $plusTimer,
                  longPressCallBack: {
                    model.modifyCount(1)
                  }))

              Divider()
                .frame(height: 1)
                .getContrastBackgroundColor(backgroundColor: backgroundColor)

              Button(action: {
                if(isLongPressing){
                  isLongPressing.toggle()
                  minusTimer?.invalidate()
                  minusTimer = nil
                } else {
                  model.modifyCount(-1)
                }
              }, label: {
                Rectangle()
                  .frame(maxWidth: geom.size.width, maxHeight: geom.size.height/2)
                  .foregroundStyle(minusTimer != nil ? Color.gray.opacity(0.8) : Color.clear)
              })
              .modifier(
                ButtonLongPressModifier(
                  isLongPressing: $isLongPressing, holdTimer: $minusTimer,
                  longPressCallBack: {
                    model.modifyCount(-1)
                  }))
            }
          }
          .padding(5)
          .background(backgroundColor)
          .frame(width: geom.size.width, height: geom.size.height)

        case .horizontal:
          HStack {
            Button(action: {
              if(isLongPressing){
                isLongPressing.toggle()
                minusTimer?.invalidate()
              } else {
                model.modifyCount(-1)
              }
            }, label: {
              Image(systemName: "minus")
                .imageModifier(size: geom.size.width * FancyCounterView.buttonProportion)
            })
            .modifier(
              ButtonLongPressModifier(
                isLongPressing: $isLongPressing, holdTimer: $minusTimer,
                longPressCallBack: {
                  model.modifyCount(-1)
                }))
            .padding(5)

            Text("\(model.count)")
              .font(.system(size: 500))
              .minimumScaleFactor(0.01)
              .frame(maxWidth: geom.size.width * 0.8, maxHeight: geom.size.width * 0.8)

            Button(action: {
              if(isLongPressing){
                isLongPressing.toggle()
                plusTimer?.invalidate()
              } else {
                model.modifyCount(1)
              }
            }, label: {
              Image(systemName: "plus")
                .imageModifier(size: geom.size.width * FancyCounterView.buttonProportion)
            })
            .modifier(
              ButtonLongPressModifier(
                isLongPressing: $isLongPressing, holdTimer: $plusTimer,
                longPressCallBack: {
                  model.modifyCount(1)
                }))
            .padding(5)
          }
          .padding(5)
          .background(backgroundColor)
          .frame(width: geom.size.width, height: geom.size.height)
        }
      }
    }
}

struct FancyCounterView_Previews: PreviewProvider {
  @State static var infect = 0

  static var previews: some View {
    FancyCounterView(model: .init(count: $infect, orientation: .horizontal), backgroundColor: .constant(.clear))
  }
}

enum CounterOrientation {
  case vertical, horizontal
}

class CounterModel: ObservableObject {
  @Binding var count: Int
  var orientation: CounterOrientation
  var countDidChange: ((Int) -> ())?

  init(count: Binding<Int>, orientation: CounterOrientation, countDidChange: ((Int) -> ())? = nil) {
    self._count = count
    self.orientation = orientation
    self.countDidChange = countDidChange
  }

  func modifyCount(_ value: Int) {
    count += value
    countDidChange?(value)
  }
}

