//
//  LifeTrackerView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

struct LifeTrackerView: View {

  @Binding var count: Int
  var backgroundColor: Color = .blue

  var body: some View {
    GeometryReader { geom in
      HStack(alignment: .center) {
        Spacer()
        Button(action: {
          print("Minus Button Pressed")
        }, label: {
          Image(systemName: "minus")
            .resizable()
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
            .modifier(FitImageToLifeTracker(geom: geom))
        })

        TrackerView(count: $count, trackerType: .life, backgroundColor: backgroundColor)

        Button(action: {
          print("Plus Button Pressed")
        }, label: {
          Image(systemName: "plus")
            .resizable()
            .scaledToFit()
            .getContrastColor(backgroundColor: backgroundColor)
            .modifier(FitImageToLifeTracker(geom: geom))
        })
        Spacer()
      }
    }
    .background(backgroundColor)
  }
}

struct LifeTrackerView_Previews: PreviewProvider {
  @State static var count = 22

  static var previews: some View {
    LifeTrackerView(count: $count)
  }
}

struct FitImageToLifeTracker: ViewModifier {
  var geom: GeometryProxy

  func body(content: Content) -> some View {
    content
      .frame(width: geom.smallerDimension() * 0.25, height: geom.smallerDimension() * 0.25)
  }
}
