//
//  UserProfile.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/2/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

enum Gender {
  case male
  case female
}

struct UserProfile {

  var gender: Gender = .male
  var height: CGFloat = 6.0 * .foot
  var weight: CGFloat = 160.0 * .pound
  var dateOfBirth: Date = Date(timeIntervalSince1970: -365 * .day)
}
