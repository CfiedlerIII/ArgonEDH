//
//  PlayerColorView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/16/25.
//

import SwiftUI

struct PlayerColorView: View {
  private let topRowColors = [Color.blue, Color.green, Color.red, Color.yellow]
  private let bottomRowColors = [Color(red: 0.988, green: 0.011, blue: 0.517), Color.orange, Color.white, Color.black]
  @Binding var backgroundColor: Color
  @Binding var isChangingColor: Bool

    var body: some View {
      ZStack {
        Color.gray.opacity(0.4)
        VStack {
          Spacer()
          HStack {
            Spacer()
            ForEach(topRowColors, id: \.self) { color in
              color
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                  backgroundColor = color
                  isChangingColor = false
                }
            }
            Spacer()
          }
          HStack {
            Spacer()
            ForEach(bottomRowColors, id: \.self) { color in
              color
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                  backgroundColor = color
                  isChangingColor = false
                }
            }
            Spacer()
          }
          Spacer()
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
  PlayerColorView(backgroundColor: .constant(.gray), isChangingColor: .constant(false))
}
