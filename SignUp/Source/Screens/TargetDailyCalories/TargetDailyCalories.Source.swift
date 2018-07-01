//
//  TargetDailyCalories.Source.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit
import class Utility.FormatterPool

extension TargetDailyCalories {

  // +1, 2, 3, 4
  // -2, 1.5, 1, 0.75, 0.5, 0.25
  enum WeekRate: PickerElement {
    case gain(CGFloat)
    case lose(CGFloat)

    static func allGains() -> [WeekRate] {
      return [.gain(1.0), .gain(2.0), .gain(3.0), .gain(4.0)]
    }

    static func allLoses() -> [WeekRate] {
      return [.lose(2.0), .lose(1.5), .lose(1.0), .lose(0.75), .lose(0.5), .lose(0.25)]
    }

    var title: String {
      let rate: CGFloat
      switch self {
      case .gain(let value): rate = value
      case .lose(let value): rate = value
      }

      let locale = Locale.current
      let numberFormatter = FormatterPool.formatter(NumberFormatter.self, format: .decimal, locale: locale)
      numberFormatter.allowsFloats = true
      numberFormatter.maximumFractionDigits = 2
      numberFormatter.minimumFractionDigits = 0
      numberFormatter.alwaysShowsDecimalSeparator = false
      let number = NSNumber(value: Double(rate))
      let value = numberFormatter.string(from: number)
      return value.map { "\($0) \(L10n.Common.Metrics.Weight.pounds)/\(L10n.Common.Metrics.Time.week)" } ?? "-"
    }
  }

  class Source: PickerSource<WeekRate> {

    var isGaining = false { didSet { reload() } }

    override init() {
      super.init()
      reload()
    }
  }
}

// MARK: - Private

private extension TargetDailyCalories.Source {

  func reload() {
    if isGaining {
      sections = [TargetDailyCalories.WeekRate.allGains()]
      setSelectedItems([.gain(1.0)])
    } else {
      sections = [TargetDailyCalories.WeekRate.allLoses()]
      setSelectedItems([.lose(1.0)])
    }
  }
}
