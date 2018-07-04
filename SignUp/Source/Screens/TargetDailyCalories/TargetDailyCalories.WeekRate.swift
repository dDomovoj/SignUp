//
//  TargetDailyCalories.WeekRate.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit
import class Utility.FormatterPool

extension TargetDailyCalories {

  struct WeekRate: PickerElement {

    let amount: CGFloat
    let titleFormatter: (_ amount: CGFloat, _ isShort: Bool) -> String

    var title: String {
      return titleFormatter(amount, false)
    }

    var shortTitle: String {
      return titleFormatter(amount, true)
    }

    static func == (lhs: TargetDailyCalories.WeekRate, rhs: TargetDailyCalories.WeekRate) -> Bool {
      return lhs.title == rhs.title
    }
  }
}
