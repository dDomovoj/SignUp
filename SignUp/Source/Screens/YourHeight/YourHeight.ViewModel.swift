//
//  YourHeight.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

extension YourHeight {

  class ViewModel {

    typealias Source = PickerSource<Value>

    private(set) var userProfile: UserProfile
    let userTarget: UserTarget
    let source = Source()

    private static let smallestHeight: CGFloat = 0.56
    private static let greatestHeight: CGFloat = 2.72

    private var metrics: Metrics { return userProfile.metrics }

    // MARK: - Bindings

    var didUpdateHeight: ((String) -> Void)? { didSet { didUpdateHeight?(heightStringValue()) } }

    // MARK: - Init

    init(userProfile: UserProfile, userTarget: UserTarget) {
      self.userProfile = userProfile
      self.userTarget = userTarget
      setup()
    }

    // MARK: - Public

    func syncData(completion: @escaping (Error?) -> Void) {
      DispatchQueue.main.async { [weak self] in
        guard let `self` = self else { return }

        switch self.userProfile.height {
        case ..<type(of: self).smallestHeight:
          completion(Error.tooLightWeight)
        case (type(of: self).greatestHeight)...:
          completion(Error.tooHeavyWeight)
        default:
          if self.userProfile.isSyncedWithHealthKit {
            HealthKitService.instance.setHeight(self.userProfile.height)
          }
          completion(nil)
        }
      }
    }
  }
}

// MARK: - Private

private extension YourHeight.ViewModel {

  func setup() {
    source.sections = sourceSections()
    source.setSelectedItems(selectedItems())
    source.action = { [weak self] value in
      guard let `self` = self else { return }

      if let major = value.first?.amount, let minor = value.last?.amount {
        let height: CGFloat
        switch self.metrics {
        case .metric: height = CGFloat(major) * CGFloat.meter + CGFloat(minor) * CGFloat.centimeter
        case .imperial: height = CGFloat(major) * CGFloat.foot + CGFloat(minor) * CGFloat.inch
        }
        self.userProfile.height = height
      }
      self.didUpdateHeight?(self.heightStringValue())
    }
  }

  func sourceSections() -> [Source.Section] {
    switch metrics {
    case .imperial:
      let feetCount = type(of: self).greatestHeight.asLength(from: .imperial, to: .imperial).major
      let feet = (0...feetCount).map {
        valueGenerator($0, foot, self.feet)
      }

      let inchesCount = Int(ceil(CGFloat.foot / CGFloat.inch))
      let inches = (1..<inchesCount).map {
        valueGenerator($0, inch, self.inches)
      }

      return [feet, inches]
    case .metric:
      let metersCount = type(of: self).greatestHeight.asLength(from: .metric, to: .metric).major
      let meters = (0...metersCount).map {
        valueGenerator($0, meter, self.meters)
      }

      let centimetersCount = Int(ceil(CGFloat.meter / CGFloat.centimeter))
      let centimeters = (1..<centimetersCount).map {
        valueGenerator($0, centimeter, self.centimeters)
      }
      return [meters, centimeters]
    }
  }

  func selectedItems() -> Source.Section {
    let height = userProfile.height.asLength(from: .metric, to: metrics)
    let major: YourHeight.Value
    switch metrics {
    case .metric:
      major = valueGenerator(height.major, meter, meters)
    case .imperial:
      major = valueGenerator(height.major, foot, feet)
    }

    let minor: YourHeight.Value
    switch metrics {
    case .metric:
      minor = valueGenerator(height.minor, centimeter, centimeters)
    case .imperial:
      minor = valueGenerator(height.minor, inch, inches)
    }
    return [major, minor]
  }

  func valueGenerator(_ amount: Int, _ single: String, _ plural: String) -> YourHeight.Value {
    return YourHeight.Value(amount: amount) {
      if $0 != 11, ($0 % 10) == 1 {
        return "\($0) \(single)"
      }
      return "\($0) \(plural)"
    }
  }

  func heightStringValue() -> String {
    return source.selectedItems.reduce("") { $0 + " \($1.title)" }
  }
}

// MARK: - Utils

private extension YourHeight.ViewModel {

  var foot: String { return L10n.Common.Metrics.Length.Feet.single }
  var feet: String { return L10n.Common.Metrics.Length.Feet.plural }
  var inch: String { return L10n.Common.Metrics.Length.Inches.single }
  var inches: String { return L10n.Common.Metrics.Length.Inches.plural }
  var meter: String { return L10n.Common.Metrics.Length.Meters.single }
  var meters: String { return L10n.Common.Metrics.Length.Meters.plural }
  var centimeter: String { return L10n.Common.Metrics.Length.Centimeters.single }
  var centimeters: String { return L10n.Common.Metrics.Length.Centimeters.plural }

}
