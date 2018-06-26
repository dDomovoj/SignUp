//
//  PagingCollectionCell.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import PinLayout

class PagingCollectionCell: Cell, Reusable {

  struct Data {
    let imageUrl: String
  }

  let imageView = ImageView()

  override func setup() {
    super.setup()
    contentView.addSubview(imageView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.pin.all()
  }

  func setup(with data: Data) {
    
  }
}
