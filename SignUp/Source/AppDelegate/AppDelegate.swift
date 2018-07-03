//
//  AppDelegate.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/23/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import class Utility.UI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    setupUI()
    return true
  }

  func application(_ application: UIApplication,
                   supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return .portrait
  }
}

// MARK: - Private

private extension AppDelegate {

  func setupUI() {
    UI.baseWidths = [.phone: 640]
    let viewController = YourHeight.ViewController(userProfile: UserProfile(),
                                                   userTarget: UserTarget(bodyMass: UserProfile().bodyMass))
    let navigationController = NavigationController(rootViewController: viewController)
    let bounds = UIScreen.main.bounds
    window = UIWindow(frame: bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
