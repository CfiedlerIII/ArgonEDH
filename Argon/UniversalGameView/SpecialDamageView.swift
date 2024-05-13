//
//  SpecialDamageView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/12/24.
//

import SwiftUI

struct SpecialDamageView: View {
  @Binding var isDisplayed: Bool

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          Text("Special Damage")
            .font(.system(size: 28))
            .padding()
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
          Divider()
          Spacer()
        }
      }
    }
  }
}

struct SpecialDamageView_Previews: PreviewProvider {
  @State static var isDisplayed: Bool = false
  static var previews: some View {
    SpecialDamageView(isDisplayed: $isDisplayed)
  }
}
