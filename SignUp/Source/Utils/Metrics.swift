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
  static let meter: CGFloat = 1.0
  static let centimeter: CGFloat = 0.01

  static let pound: CGFloat = 0.453592
  static let kilogram: CGFloat = 1.0

  func asLength(from: Metrics, to: Metrics) -> (major: Int, minor: Int) {
    switch (from, to) {
    case (.metric, .metric):
      let meter = type(of: self).meter
      let centimeter = type(of: self).centimeter
      let centimetersPerMeter = centimeter / meter
      let metersCount = floor(self)
      let centimetersCount = floor((self - metersCount) / centimetersPerMeter)
      return (Int(metersCount), Int(centimetersCount))
    case (.imperial, .imperial):
      let foot = type(of: self).foot
      let inch = type(of: self).inch
      let inchesPerFoot = inch / foot
      let feetCount = floor(self)
      let inchesCount = floor((self - feetCount) / inchesPerFoot)
      return (Int(feetCount), Int(inchesCount))
    case (.metric, .imperial):
      let foot = type(of: self).foot
      let meter = type(of: self).meter
      let feetPerMeter = foot / meter
      let feet = self / feetPerMeter
      return feet.asLength(from: .imperial, to: .imperial)
    case (.imperial, .metric):
      let foot = type(of: self).foot
      let meter = type(of: self).meter
      let feetPerMeter = foot / meter
      let meters = self * feetPerMeter
      return meters.asLength(from: .metric, to: .metric)
    }
  }

  func asWeight(from: Metrics, to: Metrics) -> CGFloat {
    switch (from, to) {
    case (.metric, .imperial):
      let poundsPerKilogram = type(of: self).pound / type(of: self).kilogram
      return self / poundsPerKilogram
    case (.imperial, .metric):
      let kilosPerPound = type(of: self).kilogram / type(of: self).pound
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
  static let year: TimeInterval = .day * 365
}
