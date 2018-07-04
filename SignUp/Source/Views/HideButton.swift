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

  override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
    return super.titleRect(forContentRect: contentRect)
  }

  override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
    return super.imageRect(forContentRect: contentRect)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    let titleRect = self.titleRect(forContentRect: bounds)
    let imageRect = self.imageRect(forContentRect: bounds)
    let padding = 8.ui
    let imageOffset = (imageRect.width + padding * 0.5)
    let titleOffset = (titleRect.width + padding * 0.5)
    titleEdgeInsets = UIEdgeInsets(0.0, -imageOffset, 0.0, imageOffset)
    imageEdgeInsets = UIEdgeInsets(0.0, titleOffset, 0.0, -titleOffset)
  }

  override func tintColorDidChange() {
    super.tintColorDidChange()
    update()
  }
}

// MARK: - Private

private extension HideButton {

  func update() {
    guard superview != nil else { return }

    let tintColor = self.tintColor ?? self.color
    let color = tintColor.hsbaValue().saturation == 0 ? tintColor : self.color
    let image = UIImage.pixel(with: color)
    setBackgroundImage(image, for: .normal)

    let title = self.title?.uppercased()
      .withFont(Fonts.OpenSans.semibold.font(size: 20.ui))
      .withTextColor(Colors.white)
    setAttributedTitle(title, for: .normal)
    setImage(Images.Ui.hideButton.image, for: .normal)
    imageView?.tintColor = Colors.white.withAlphaComponent(0.7)
  }
}
