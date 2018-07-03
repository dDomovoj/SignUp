//
//  Metrics.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/2/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

enum Metrics: String, Codable {
  case metric
  case imperial
}

extension CGFloat {

  static let foot: CGFloat = 0.3048
  static let inch: CGFloat = 0.0254
  static let centimeter: CGFloat = 0.01
  static let pound: CGFloat = 0.453592

  func asLength(in metrics: Metrics) -> (major: Int, minor: Int) {
    switch metrics {
    case .imperial:
      let metersPerFoot = type(of: self).foot
      let metersPerInch = type(of: self).inch
      let feet = floor(self / metersPerFoot)
      let inches = floor((self - feet * metersPerFoot) / metersPerInch)
      return (Int(feet), Int(inches))
    case .metric:
      let metersPerCentimeter = type(of: self).centimeter
      let meters = floor(self)
      let centimeters = floor((self - meters) / metersPerCentimeter)
      return (Int(meters), Int(centimeters))
    }
  }

  func asWeight(from: Metrics, to: Metrics) -> CGFloat {
    switch (from, to) {
    case (.metric, .imperial):
      let poundsPerKilogram = type(of: self).pound
      return self / poundsPerKilogram
    case (.imperial, .metric):
      let kilosPerPound = 1.0 / type(of: self).pound
      return self / kilosPerPound
    default:
      return self
    }
  }
}

extension TimeInterval {

  static let second: TimeInterval = 1
  static let minute: TimeInterval = .second * 60
  static let hour: TimeInterval = .minute * 60
  static let day: TimeInterval = .hour * 24
  static let week: TimeInterval = .day * 7
}
