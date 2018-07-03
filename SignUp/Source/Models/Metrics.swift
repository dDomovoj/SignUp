//
//  Metrics.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/2/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

extension CGFloat {

  static let foot: CGFloat = 0.3048
  static let inch: CGFloat = 0.0254
  static let pound: CGFloat = 0.453592
}

extension TimeInterval {

  static let second: TimeInterval = 1
  static let minute: TimeInterval = .second * 60
  static let hour: TimeInterval = .minute * 60
  static let day: TimeInterval = .hour * 24
  static let week: TimeInterval = .day * 7
}
