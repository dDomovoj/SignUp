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

  enum Defaults {
    static let date = Date().addingTimeInterval(.week * 4)
  }

  var date: Date = Defaults.date
  var bodyMass: CGFloat

  init(bodyMass: CGFloat) {
    self.bodyMass = bodyMass
  }
}
