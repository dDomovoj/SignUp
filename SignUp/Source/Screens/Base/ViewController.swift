//
//  ViewController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/23/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import PinLayout
import Utility

class ViewController: UIViewController {

  let titleLabel = Label().with {
    $0.shouldInheritTintColor = true
    $0.font = Fonts.OpenSans.regular.font(size: 44.ui)
    $0.textAlignment = .center
  }

  // MARK: - Properties

  var activeViewController: UIViewController? {
    if let presentedViewController = presentedViewController, !presentedViewController.isBeingDismissed {
      return presentedViewController
    }
    return nil
  }

  var safeTopGuide: CGFloat { return topLayoutGuide.length }

  // MARK: - Overrides

  override var shouldAutorotate: Bool {
    return activeViewController?.shouldAutorotate ?? true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return activeViewController?.supportedInterfaceOrientations ?? .portrait
  }

  override var prefersStatusBarHidden: Bool {
    return activeViewController?.prefersStatusBarHidden ?? false
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return activeViewController?.preferredStatusBarStyle ?? .default
  }

  @available(iOS 11.0, *)
  override func prefersHomeIndicatorAutoHidden() -> Bool {
    return activeViewController?.prefersHomeIndicatorAutoHidden() ?? true
  }

  // MARK: - Init

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func loadView() {
    super.loadView()
    navigationItem.title = ""
    navigationItem.titleView = titleLabel
    view.backgroundColor = Colors.white
  }

  // MARK: - Public

}
