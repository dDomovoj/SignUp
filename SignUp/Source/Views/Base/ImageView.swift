//
//  ImageView.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

  override class var requiresConstraintBasedLayout: Bool {
    return false
  }

  // MARK: - Init

  convenience init() {
    self.init(frame: .zero)
  }

  convenience override init(image: UIImage?) {
    let frame = image.map { CGRect(origin: .zero, size: $0.size) } ?? .zero
    self.init(frame: frame)
    self.image = image
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setup() { }
}
