//
//  ArgonApp.swift
//  Argon
//
//  Created by Charles Fiedler on 5/6/24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  static var orientationLock = UIInterfaceOrientationMask.all {
    didSet {
      if #available(iOS 16.0, *) {
        UIApplication.shared.connectedScenes.forEach { scene in
          if let windowScene = scene as? UIWindowScene {
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
          }
        }
        UIViewController.attemptRotationToDeviceOrientation()
      } else {
        if orientationLock == .landscape {
          UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        } else {
          UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
      }
    }
  }

  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return AppDelegate.orientationLock
  }
}

@main
struct ArgonApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
          Navigator()
        }
    }
}
