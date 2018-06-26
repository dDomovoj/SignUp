//
//  ColorButton.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit
import SwiftyAttributes
import PinLayout

class GreenButton: Button {

  var title: String? { didSet { update() } }
  var subtitle: String? { didSet { update() } }

  let subtitleLabel = Label().with {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  override func setup() {
    super.setup()
    let image = UIImage.pixel(with: Colors.green)
    setBackgroundImage(image, for: .normal)
    clipsToBounds = true
    layer.cornerRadius = 6.ui
    addSubview(subtitleLabel)
  }

  override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
    var rect = super.titleRect(forContentRect: contentRect)
    if (subtitle?.length ?? 0) > 0 {
      rect.origin.y -= 20.ui
    }
    return rect
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    subtitleLabel.pin
      .top(to: titleLabel?.edge.bottom ?? edge.vCenter).marginTop(-10.ui)
      .start(36.ui).end(36.ui)
      .sizeToFit(.widthFlexible)
  }
}

// MARK: - Private

private extension GreenButton {

  func update() {
    let title = self.title?.uppercased()
      .withFont(Fonts.OpenSans.regular.font(size: 64.ui))
      .withTextColor(Colors.white)
    setAttributedTitle(title, for: .normal)

    subtitleLabel.isHidden = (subtitle?.length ?? 0) == 0
    subtitleLabel.attributedText = subtitle?
      .withFont(Fonts.OpenSans.semibold.font(size: 40.ui))
      .withTextColor(Colors.greenSalad)
    setNeedsLayout()
  }
}
