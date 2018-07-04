//
//  LargeButton.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

class LargeButton: Button {

  enum Const {
    static let height = 80.ui
  }

  var title: String? { didSet { update() } }
  var color: UIColor = Colors.green { didSet { update() } }

  // MARK: - Lifecycle

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    update()
  }

  override func tintColorDidChange() {
    super.tintColorDidChange()
    update()
  }
}

// MARK: - Private

private extension LargeButton {

  func update() {
    guard superview != nil else { return }

    let tintColor = self.tintColor ?? self.color
    let color = tintColor.hsbaValue().saturation == 0 ? tintColor : self.color
    let image = UIImage.pixel(with: color)
    setBackgroundImage(image, for: .normal)

    let title = self.title?
      .withFont(Fonts.OpenSans.semibold.font(size: 36.ui))
      .withTextColor(Colors.white)
    setAttributedTitle(title, for: .normal)
  }
}
