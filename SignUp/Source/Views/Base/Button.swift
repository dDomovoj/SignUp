//
//  Button.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

private class Target: NSObject {

  var action: Button.Action?

  @objc func fire(_ sender: Any?) {
    action?()
  }
}

class Button: UIButton {

  typealias Action = () -> Void

  private let target = Target()

  var action: Action?

  override class var requiresConstraintBasedLayout: Bool {
    return false
  }

  // MARK: Init

  required init() {
    super.init(frame: .zero)
    setupAction()
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAction()
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setup() { }
}

private extension Button {

  func setupAction() {
    target.action = { [weak self] in self?.action?() }
    addTarget(target, action: #selector(Target.fire(_:)), for: .touchUpInside)
  }
}
