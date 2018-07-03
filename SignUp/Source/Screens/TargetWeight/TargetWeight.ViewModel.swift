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

    private var metrics: Metrics { return userProfile.metrics }

    // MARK: - Init

    init(userProfile: UserProfile) {
      self.userProfile = userProfile
    }

    // MARK: - Public

    func hintTargetWeight() -> CGFloat {
      switch metrics {
      case .imperial:
        return 220.5
      case .metric:
        return 105.5
      }
    }

    func hintTargetUnit() -> String {
      switch metrics {
      case .imperial:
        return L10n.Common.Metrics.Weight.pounds
      case .metric:
        return L10n.Common.Metrics.Weight.kilos
      }
    }

    func hintTargetUnitFull() -> String {
      switch metrics {
      case .imperial:
        return L10n.Common.Metrics.Weight.poundsFull
      case .metric:
        return L10n.Common.Metrics.Weight.kilosFull
      }
    }

    func initialTargetWeight() -> CGFloat {
      return userProfile.bodyMass.asWeight(from: .metric, to: metrics) * 0.9
    }

    func updateWeight(_ value: CGFloat) {
      let bodyMass = value.asWeight(from: metrics, to: .metric)
      userProfile.targetBodyMass = bodyMass
    }

    func syncData(completion: @escaping (Error?) -> Void) {
      DispatchQueue.main.async { [weak self] in
        guard let `self` = self else { return }

        switch self.userProfile.targetBodyMass {
        case ..<20:
          completion(Error.tooLightWeight)
        case 500...:
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
