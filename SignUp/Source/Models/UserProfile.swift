//
//  UserProfile.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/2/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

struct UserProfile: Codable {

  enum Defaults {
    static let height: CGFloat = 6.0 * .foot
    static let bodyMass: CGFloat = 160.0 * .pound
    static let dateOfBirth = Calendar.current.date(byAdding: .year, value: -35, to: Date())
      ?? Date().addingTimeInterval(-35 * .year)
  }

  var gender = Gender.male
  var height = Defaults.height
  var bodyMass = Defaults.bodyMass
  var dateOfBirth = Defaults.dateOfBirth

  var isSyncedWithHealthKit = false
  var metrics = Metrics.metric
}

// MARK: - Gender

extension UserProfile {

  enum Gender: String, Codable {
    case male
    case female
  }
}
