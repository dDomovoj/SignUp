//
//  TargetDailyCaloies.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat
import class Utility.FormatterPool

extension TargetDailyCalories {

  class ViewModel {

    typealias Source = PickerSource<WeekRate>

    // MARK: - Properties

    var targetDate: Date { return userTarget.date }

    var isLosingWeight: Bool {
      return userProfile.bodyMass > userTarget.bodyMass
    }

    var fromWeight: String {
      return userProfile.bodyMass.asWeight(from: .metric, to: metrics).formatted(".0") + weightSuffix
    }

    var toWeight: String {
      return userTarget.bodyMass.asWeight(from: .metric, to: metrics).formatted(".0") + weightSuffix
    }

    var normalRate: String {
      switch metrics {
      case .imperial:
        return "1 \(L10n.Common.Metrics.Weight.Pounds.short)/\(L10n.Common.Metrics.Time.week)"
      case .metric:
        let value = CGFloat(1.0).asWeight(from: .imperial, to: .metric).formatted(".2")
        return "\(value) \(L10n.Common.Metrics.Weight.Kilos.short)/\(L10n.Common.Metrics.Time.week)"
      }
    }

    let source = Source()
    private(set) var userProfile: UserProfile
    private(set) var userTarget: UserTarget

    private var metrics: Metrics { return userProfile.metrics }
    private var weightSuffix: String {
      return metrics == .metric ? L10n.Common.Metrics.Weight.Kilos.short : L10n.Common.Metrics.Weight.Pounds.short
    }
    private var numberFormatter: NumberFormatter {
      let numberFormatter = FormatterPool.formatter(NumberFormatter.self, format: .decimal, locale: .current)
      numberFormatter.allowsFloats = true
      numberFormatter.maximumFractionDigits = 2
      numberFormatter.minimumFractionDigits = 0
      numberFormatter.alwaysShowsDecimalSeparator = false
      return numberFormatter
    }

    // MARK: - Bindings

    private(set) var dailyCalories: Int = 0 { didSet { didUpdateDailyCalories?(dailyCalories) } }

    private var weekRate: WeekRate? { didSet { didUpdateWeekRate?(weekRate) } }

    var didUpdateDailyCalories: ((Int) -> Void)? { didSet { didUpdateDailyCalories?(dailyCalories) } }
    var didUpdateTargetDate: ((Date) -> Void)? { didSet { didUpdateTargetDate?(targetDate) } }
    var didUpdateWeekRate: ((WeekRate?) -> Void)? { didSet { didUpdateWeekRate?(weekRate) } }

    // MARK: - Init

    init(userProfile: UserProfile, userTarget: UserTarget) {
      self.userProfile = userProfile
      self.userTarget = userTarget
      setup()
    }

    // MARK: - Public

    func updateTargetDate(_ date: Date) {
      userTarget.date = date
      didUpdateTargetDate?(date)
      updateWeekRateForSelectedTargetDate()
      calculateDailyCalories()
    }

    // MARK: - Public

    func syncData(completion: @escaping (Error?) -> Void) {
      PersistenceService.storeUserData(userProfile: userProfile, userTarget: userTarget) { _ in
        completion(nil)
      }
    }
  }
}

// MARK: - Private

private extension TargetDailyCalories.ViewModel {

  func setup() {
    source.sections = sourceSections()
    source.setSelectedItems(selectedSection())
    source.action = { [weak self] rate in
      guard let `self` = self else { return }

      self.weekRate = rate.first
      if let amount = rate.first?.amount {
        let sign: CGFloat = self.isLosingWeight ? -1.0 : 1.0
        let weekRate = amount.asWeight(from: self.metrics, to: .metric)
        self.userTarget.weekRate = weekRate * sign
        self.updateTargetDateForSelectedWeekRate()
      }
      self.calculateDailyCalories()
    }
  }

  func sourceSections() -> [Source.Section] {
    typealias WeekRate = TargetDailyCalories.WeekRate

    let prefix = isLosingWeight ? L10n.TargetDailyCalories.losing : L10n.TargetDailyCalories.gaining
    let units = metrics == .metric ? L10n.Common.Metrics.Weight.Kilos.short : L10n.Common.Metrics.Weight.Pounds.short
    let amounts: [CGFloat] = isLosingWeight
      ? [2.0, 1.5, 1.0, 0.75, 0.5, 0.25]
      : [1.0, 2.0, 3.0, 4.0]
    let weekRates = amounts.map { metrics == .metric ? $0 * .pound : $0 }
      .map {
        WeekRate(amount: $0) { [weak self] rate, short in
          let number = NSNumber(value: Double(rate))
          guard let value = self?.numberFormatter.string(from: number) else { return "-" }

          let shortString = "\(value) \(units)/\(L10n.Common.Metrics.Time.week)"
          if short {
            return shortString
          }
          return prefix + " " + shortString
        }
    }
    return [weekRates]
  }

  func selectedSection() -> Source.Section {
    let amount = metrics == .metric ? CGFloat.pound : 1.0
    let result = source.sections
      .first?
      .filter { $0.amount == amount }
      .first
    return result.map { [$0] } ?? []
  }

  func updateTargetDateForSelectedWeekRate() {
    let dayRate = userTarget.weekRate / 7.0
    let bodyMassChange = userTarget.bodyMass - userProfile.bodyMass
    let daysCount = Double(bodyMassChange / dayRate)
    userTarget.date = Date().addingTimeInterval(.day * daysCount)
    didUpdateTargetDate?(userTarget.date)
  }

  func updateWeekRateForSelectedTargetDate() {
    let daysCount = CGFloat(userTarget.date.timeIntervalSince(Date()) / .day)
    let bodyMassChange = userTarget.bodyMass - userProfile.bodyMass
    let dayRate = bodyMassChange / daysCount
    let weekRate = dayRate * 7.0
    userTarget.weekRate = weekRate

    let prefix = isLosingWeight ? L10n.TargetDailyCalories.losing : L10n.TargetDailyCalories.gaining
    let units = metrics == .metric ? L10n.Common.Metrics.Weight.Kilos.short : L10n.Common.Metrics.Weight.Pounds.short
    let value = TargetDailyCalories.WeekRate(amount: abs(weekRate)) { [weak self] rate, short in
      let number = NSNumber(value: Double(rate))
      guard let value = self?.numberFormatter.string(from: number) else { return "-" }

      let shortString = "\(value) \(units)/\(L10n.Common.Metrics.Time.week)"
      if short {
        return shortString
      }
      return prefix + " " + shortString
    }
    didUpdateWeekRate?(value)
  }

  func calculateDailyCalories() {
    dailyCalories = CaloriesCalculator.energyRequirenments(for: userProfile, with: userTarget)
  }
}
