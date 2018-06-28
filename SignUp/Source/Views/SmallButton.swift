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

class SmallButton: Button {

  enum Const {
    static let height = 90.ui
  }

  let subtitleLabel = Label().with {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  var title: String? { didSet { update() } }
  var subtitle: String? { didSet { update() } }
  var color: UIColor = Colors.green { didSet { update() } }

  // MARK: - Lifecycle

  override func setup() {
    super.setup()
    clipsToBounds = true
    layer.cornerRadius = 3.ui
    addSubview(subtitleLabel)
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    update()
  }

  override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
    var rect = super.titleRect(forContentRect: contentRect)
    if (subtitle?.length ?? 0) > 0 {
      rect.origin.y -= 10.ui
    }
    return rect
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    subtitleLabel.pin
      .top(to: titleLabel?.edge.bottom ?? edge.vCenter).marginTop(-5.ui)
      .start(18.ui).end(18.ui)
      .sizeToFit(.widthFlexible)
  }
}

// MARK: - Private

private extension SmallButton {

  func update() {
    guard superview != nil else { return }

    let image = UIImage.pixel(with: color)
    setBackgroundImage(image, for: .normal)

    let title = self.title?.uppercased()
      .withFont(Fonts.OpenSans.regular.font(size: 32.ui))
      .withTextColor(Colors.white)
    setAttributedTitle(title, for: .normal)

    subtitleLabel.isHidden = (subtitle?.length ?? 0) == 0
    subtitleLabel.attributedText = subtitle?
      .withFont(Fonts.OpenSans.semibold.font(size: 20.ui))
      .withTextColor(Colors.greenSalad)
    setNeedsLayout()
  }
}
