//
//  ModalCloseModifier.swift
//  Argon
//
//  Created by Charles Fiedler on 5/12/24.
//

import SwiftUI

struct ModalCloseModifier: ViewModifier {
  let title: String
  @Binding var isDisplayed: Bool
  @Binding var specialDMGPresenter: (Int,Angle,Bool)?

  init(title: String, isDisplayed: Binding<Bool> = .constant(false), specialDMGPresenter: Binding<(Int, Angle,Bool)?> = .constant(nil)) {
    self.title = title
    self._isDisplayed = isDisplayed
    self._specialDMGPresenter = specialDMGPresenter
  }

  func body(content: Content) -> some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          Text(title)
            .font(.system(size: 28))
            .padding()
          Divider()
          content
          Spacer()
        }
        VStack {
          HStack {
            Button(action: {
              specialDMGPresenter = nil
              isDisplayed = false
            }, label: {
              Image(systemName: "xmark")
                .resizable()
                .frame(width: 28, height: 28, alignment: .center)
            })
            .padding()
            .tint(.black)
            Spacer()
          }
          Spacer()
        }
      }
    }
  }
}
