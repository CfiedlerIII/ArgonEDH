//
//  ClearBackgroundView.swift
//  Argon
//
//  Created by Charles Fiedler on 5/23/24.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {
  func makeUIView(context: Context) -> some UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }
  func updateUIView(_ uiView: UIViewType, context: Context) {
  }
}

struct ClearBackgroundViewModifier: ViewModifier {

  func body(content: Content) -> some View {
    content
      .background(ClearBackgroundView())
  }
}

extension View {
  func clearModalBackground()->some View {
    self.modifier(ClearBackgroundViewModifier())
  }
}

extension View {
  func blurredSheet<Content: View>(
    _ style: AnyShapeStyle,
    show: Binding<Bool>,
    onDismiss: @escaping () -> (),
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    self
      .sheet(isPresented: show, onDismiss: onDismiss) {
        content()
          .background(RemoveBackgroundColor())
    }
  }
}

fileprivate struct RemoveBackgroundColor: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return UIView()
  }

  func updateUIView(_ uiView: UIView, context: Context) {
    DispatchQueue.main.async {
      uiView.superview?.superview?.backgroundColor = .clear
    }
  }
}
