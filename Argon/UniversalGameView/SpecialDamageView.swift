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
      Text("View Body")
        .modifier(ModalCloseWrapper(title: "Special Damage", isDisplayed: $isDisplayed))
    }
  }
}

struct SpecialDamageView_Previews: PreviewProvider {
  @State static var isDisplayed: Bool = false
  static var previews: some View {
    SpecialDamageView(isDisplayed: $isDisplayed)
  }
}
