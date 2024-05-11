//
//  TrackerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

enum TrackerType {
  case life, infect, cmdr

  func getImage() -> Image {
    switch self {
    case .life:
      Image(systemName: "heart.fill")
    case .infect:
      Image(systemName: "drop.fill")
    case .cmdr:
      Image(systemName: "shield.fill")
    }
  }
}

struct TrackerView: View {

  @Binding var count: Int
  var trackerType: TrackerType
  var backgroundColor: Color = .black

  var body: some View {
    GeometryReader { geom in
      HStack(alignment: .center) {
        Spacer()
        VStack(alignment: .center) {
          Spacer()
          ZStack {
            trackerType.getImage()
              .resizable()
              .font(.system(size: 5000).weight(.ultraLight))
              .aspectRatio(contentMode: .fit)
              .getContrastColor(backgroundColor: backgroundColor)
            Text("\(count)")
              .getContrastColor(backgroundColor: backgroundColor, reversed: true)
                .lineLimit(1)
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
                .modifier(FitTextToTracker(geom: geom))
                .padding(.bottom, 10)
          }
          Spacer()
        }
        Spacer()
      }
    }
    .background(backgroundColor)
  }
}

struct TrackerView_Previews: PreviewProvider {
  @State static var count = 8

  static var previews: some View {
    TrackerView(count: $count, trackerType: .life)
  }
}

struct FitTextToTracker: ViewModifier {
  var geom: GeometryProxy

  func body(content: Content) -> some View {
    content
      .frame(width: geom.smallerDimension() * 0.65, height: geom.smallerDimension() * 0.85)
  }
}
