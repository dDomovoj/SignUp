//
//  Cell.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {

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
