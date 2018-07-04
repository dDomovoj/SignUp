//
//  UserTarget.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

struct UserTarget: Codable {

  enum Activity: String, Codable {
    case sedentary
    case lowActive
    case active
    case veryActive
  }

  enum Defaults {
    static let date = Calendar.current.date(byAdding: .day, value: 28, to: Date())
      ??  Date().addingTimeInterval(.week * 4)
  }

  var date: Date = Defaults.date
  var bodyMass: CGFloat
  var weekRate: CGFloat = 1.0 * .pound

  init(bodyMass: CGFloat) {
    self.bodyMass = bodyMass
  }
}
