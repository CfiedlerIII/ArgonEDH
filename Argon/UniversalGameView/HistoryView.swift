//
//  HistoryView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/12/24.
//

import SwiftUI

class History {
  var deltas: [Delta] = []

  init(deltas: [Delta] = []) {
    self.deltas = deltas
  }

  func addDelta(value: Int) {
    let newDelta = Delta(value)
    deltas.append(newDelta)
  }

  struct Delta: Identifiable {
    let id = UUID()
    var change: Int

    init(_ change: Int) {
      self.change = change
    }
  }
}

struct HistoryView: View {

  @Binding var history: History
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?

  var body: some View {
    GeometryReader { geometry in
      VStack {
        Text("Most Recent")
          .font(.system(size: 20))
        ScrollView {
          Divider()
          ForEach(history.deltas.reversed()) { delta in
            if delta.change > 0 {
              Text("+\(delta.change)")
                .font(.system(size: 30))
            } else {
              Text("\(delta.change)")
                .font(.system(size: 30))
            }
            Divider()
          }
        }
        .padding(.leading, 10)
        Text("Oldest")
          .font(.system(size: 20))
        Spacer()
      }
      .modifier(ModalCloseWrapper(title: "History", specialDMGPresenter: $specialDMGPresenter))
      .getContrastColor(backgroundColor: .white)
    }
  }
}

struct HistoryView_Previews: PreviewProvider {
  @State static var isDisplayed = true
  static let history = History(deltas: [History.Delta(4),History.Delta(-5),History.Delta(1)])

  static var previews: some View {
    HistoryView(history: .constant(history), specialDMGPresenter: .constant(nil))
  }
}
