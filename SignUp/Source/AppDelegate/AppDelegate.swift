//
//  AppDelegate.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/23/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    let bounds = UIScreen.main.bounds
    window = UIWindow(frame: bounds)
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    return true
  }
}
