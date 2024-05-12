//
//  PlayerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct PlayerView: View {
  @State var count: Int
  @State var lifeDelta: Int = 0
  var backgroundColor: Color = .pink
  var padding: CGFloat = 10
  var rotation: Angle = .zero

  var body: some View {
    GeometryReader { geom in
      VStack(alignment: .center, spacing: 0) {
        Text("\(lifeDelta)")
          .getContrastColor(backgroundColor: backgroundColor)
          .font(.system(size: 500))
          .minimumScaleFactor(0.01)
          .frame(maxHeight: geom.size.height * 0.10)
          .opacity(lifeDelta != 0 ? 1.0 : 0.0)
        LifeTrackerView(count: $count, lifeDelta: $lifeDelta, backgroundColor: backgroundColor)
          .frame(minHeight: geom.size.height * 0.4)
        PlayerSettingsView(backgroundColor: backgroundColor)
          .frame(maxHeight: geom.size.height * 0.25)
      }
      .padding(10)
    }
    .rotationEffect(rotation)
    .background(backgroundColor)
    .cornerRadius(15)
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerView(count: 2)
  }
}
