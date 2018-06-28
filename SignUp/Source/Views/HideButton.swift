//
//  HideButton.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

class HideButton: Button {

  enum Const {
    static let height = 80.ui
  }

  var title: String? { didSet { update() } }
  var color: UIColor = Colors.greenDark { didSet { update() } }

  // MARK: - Lifecycle

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    update()
  }
}

// MARK: - Private

private extension HideButton {

  func update() {
    guard superview != nil else { return }

    let image = UIImage.pixel(with: color)
    setBackgroundImage(image, for: .normal)

    let title = self.title?.uppercased()
      .withFont(Fonts.OpenSans.semibold.font(size: 20.ui))
      .withTextColor(Colors.white)
    setAttributedTitle(title, for: .normal)
  }
}
