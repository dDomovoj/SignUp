//
//  CurrentWeight.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/3/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

extension CurrentWeight {

  class ViewModel {

    private(set) var userProfile: UserProfile

    var metrics: Metrics = preferredMetrics() { didSet { updateMetrics() } }

    private static let smallestWeight: CGFloat = 20.0
    private static let greatestWeight: CGFloat = 500.0

    // MARK: - Bindings

    var metricsDidChange: ((Metrics) -> Void)? { didSet { metricsDidChange?(metrics) } }

    // MARK: - Init

    init(userProfile: UserProfile) {
      self.userProfile = userProfile
      updateMetrics()
    }

    // MARK: - Public

    func hintCurrentWeight() -> CGFloat {
      switch metrics {
      case .imperial:
        return 220.5
      case .metric:
        return 105.5
      }
    }

    func hintCurrentUnit() -> String {
      switch metrics {
      case .imperial:
        return L10n.Common.Metrics.Weight.Pounds.short
      case .metric:
        return L10n.Common.Metrics.Weight.Kilos.short
      }
    }

    func hintCurrentUnitFull() -> String {
      switch metrics {
      case .imperial:
        return L10n.Common.Metrics.Weight.Pounds.plural
      case .metric:
        return L10n.Common.Metrics.Weight.Kilos.plural
      }
    }

    func bodyMassInCurrentMetrics() -> CGFloat {
      return userProfile.bodyMass.asWeight(from: .metric, to: metrics)
    }

    func updateWeight(_ value: CGFloat) {
      let bodyMass = value.asWeight(from: metrics, to: .metric)
      userProfile.bodyMass = bodyMass
    }

    func syncData(completion: @escaping (Error?) -> Void) {
      DispatchQueue.main.async { [weak self] in
        guard let `self` = self else { return }

        switch self.userProfile.bodyMass {
        case ..<type(of: self).smallestWeight:
          completion(Error.tooLightWeight)
        case (type(of: self).greatestWeight)...:
          completion(Error.tooHeavyWeight)
        default:
          if self.userProfile.isSyncedWithHealthKit {
            HealthKitService.instance.setBodyMass(self.userProfile.bodyMass)
          }
          completion(nil)
        }
      }
    }
  }
}

// MARK: - Private

private extension CurrentWeight.ViewModel {

  static func preferredMetrics() -> Metrics {
    let locale = Locale.current
    switch locale.identifier {
    case "en-US":
      return .imperial
    default:
      return .metric
    }
  }

  func updateMetrics() {
    userProfile.metrics = metrics
    metricsDidChange?(metrics)
  }
}
