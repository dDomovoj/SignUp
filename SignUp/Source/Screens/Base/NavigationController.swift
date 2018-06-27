//
//  NavigationController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

  // MARK: - Public

  var activeViewController: UIViewController? {
    if let presentedViewController = presentedViewController, !presentedViewController.isBeingDismissed {
      return presentedViewController
    }
    return topViewController
  }

  // MARK: - Overrides

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return activeViewController?.supportedInterfaceOrientations ?? .portrait
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return activeViewController
  }

  override var childViewControllerForStatusBarHidden: UIViewController? {
    return activeViewController
  }

  override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
    return activeViewController
  }

  // MARK: - Init

  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private

private extension NavigationController {

  func setup() {
    navigationBar.tintColor = Colors.green
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    navigationBar.setBackgroundImage(UIImage(), for: .default)
  }
}
