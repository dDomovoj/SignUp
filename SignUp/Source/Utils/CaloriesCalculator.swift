//
//  CaloriesCalculator.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

final class CaloriesCalculator {

  enum Const {
    static let caloriesPerDay = CGFloat(500) / .pound
  }

  private init() { }

  class func energyRequirenments(gender: UserProfile.Gender, height: CGFloat, weight: CGFloat,
                                 activity: UserTarget.Activity, age: TimeInterval) -> Int {
    switch gender {
    case .male:
      let age: CGFloat = 9.53 * CGFloat(age)
      let weight: CGFloat = 15.91 * weight
      let height: CGFloat = 539.6 * height
      let activityLevel: CGFloat = activity.activityLevel * (weight + height)
      let calories = 662.0 - age + activityLevel
      return Int(calories)
    case .female:
      let age: CGFloat = 6.91 * CGFloat(age)
      let weight: CGFloat = 9.36 * weight
      let height: CGFloat = 726.0 * height
      let activityLevel: CGFloat = activity.activityLevel * (weight + height)
      let calories = 354.0 - age + activityLevel
      return Int(calories)
    }
  }

  // Making assumption that weight is static during calculated period
  class func energyRequirenments(for user: UserProfile, with target: UserTarget) -> Int {
    let dobValue = Calendar.current.dateComponents([.year, .day], from: user.dateOfBirth)
    let nowValue = Calendar.current.dateComponents([.year, .day], from: Date())
    let years = (nowValue.year ?? 0) - (dobValue.year ?? 0)
    let days = (nowValue.day ?? 0) - (dobValue.day ?? 0)
    let age = TimeInterval(years) + TimeInterval((days + 365) % 365) / 365.0
    let eer = energyRequirenments(gender: user.gender, height: user.height, weight: user.bodyMass,
                                  activity: .sedentary, age: age)
    return eer + Int(target.weekRate * Const.caloriesPerDay)
  }
}

// MARK: - UserTarget.Activity

fileprivate extension UserTarget.Activity {

  var activityLevel: CGFloat {
    switch self {
    case .sedentary: return 1.0
    case .lowActive: return 1.12
    case .active: return 1.27
    case .veryActive: return 1.45
    }
  }
}
