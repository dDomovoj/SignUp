//
//  Label.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class Label: UILabel {

  override class var requiresConstraintBasedLayout: Bool {
    return false
  }

  var shouldInheritTintColor: Bool = false { didSet { updateTextColorWithTintColorIfNeeded() } }

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setup() { }

  // MARK: - Overrides

  override func tintColorDidChange() {
    super.tintColorDidChange()
    updateTextColorWithTintColorIfNeeded()
  }
}

// MARK: - Private

private extension Label {

  func updateTextColorWithTintColorIfNeeded() {
    guard shouldInheritTintColor else { return }

    textColor = superview?.tintColor ?? textColor
  }
}
