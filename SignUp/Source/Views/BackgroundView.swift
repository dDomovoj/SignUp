//
//  BackgroundView.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/27/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import class Utility.GradientView

class BackgroundView: View {

  let gradientView = GradientView().with {
    let start = Colors.blueLight
    let end = Colors.white
    $0.direction = .down
    $0.colors = [(start, 0.0), (end, 1.0)].map { .init(color: $0.0, location: $0.1) }
  }

  override func setup() {
    super.setup()
    addSubview(gradientView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gradientView.pin.all()
  }
}
