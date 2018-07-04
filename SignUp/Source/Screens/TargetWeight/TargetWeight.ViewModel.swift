//
//  TargetWeight.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

extension TargetWeight {

  class ViewModel {

    private(set) var userProfile: UserProfile
    private(set) var userTarget: UserTarget

    private var metrics: Metrics { return userProfile.metrics }

    private static let smallestWeight: CGFloat = 20.0
    private static let greatestWeight: CGFloat = 500.0

    // MARK: - Init

    init(userProfile: UserProfile) {
      self.userProfile = userProfile
      userTarget = UserTarget(bodyMass: userProfile.bodyMass * 0.95)
    }

    // MARK: - Public

    func hintTargetWeight() -> CGFloat {
      return (userProfile.bodyMass * 0.95).asWeight(from: .metric, to: metrics)
    }

    func hintTargetUnit() -> String {
      switch metrics {
      case .imperial:
        return L10n.Common.Metrics.Weight.Pounds.short
      case .metric:
        return L10n.Common.Metrics.Weight.Kilos.short
      }
    }

    func hintTargetUnitFull() -> String {
      switch metrics {
      case .imperial:
        return L10n.Common.Metrics.Weight.Pounds.plural
      case .metric:
        return L10n.Common.Metrics.Weight.Kilos.plural
      }
    }

    func initialTargetWeight() -> CGFloat {
      return userTarget.bodyMass.asWeight(from: .metric, to: metrics)
    }

    func updateWeight(_ value: CGFloat) {
      let bodyMass = value.asWeight(from: metrics, to: .metric)
      userTarget.bodyMass = bodyMass
    }

    func syncData(completion: @escaping (Error?) -> Void) {
      DispatchQueue.main.async { [weak self] in
        guard let `self` = self else { return }

        switch self.userTarget.bodyMass {
        case ..<type(of: self).smallestWeight:
          completion(Error.tooLightWeight)
        case (type(of: self).greatestWeight)...:
          completion(Error.tooHeavyWeight)
        default:
          completion(nil)
        }
      }
    }
  }
}

// MARK: - Private

private extension TargetWeight.ViewModel { }
