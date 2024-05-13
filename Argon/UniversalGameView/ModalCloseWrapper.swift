//
//  ModalCloseWrapper.swift
//  Argon
//
//  Created by Charles Fiedler on 5/12/24.
//

import SwiftUI

struct ModalCloseWrapper: ViewModifier {
  let title: String
  @Binding var isDisplayed: Bool

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
