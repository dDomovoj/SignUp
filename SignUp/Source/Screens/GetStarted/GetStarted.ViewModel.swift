//
//  GetStarted.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/3/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

extension GetStarted {

  class ViewModel {

    private(set) var userProfile = UserProfile()

    var shouldUseHealthKitData = false { didSet { fetchHelthKitDataIfNeeded() } }

    private var syncGroup: DispatchGroup?

    // MARK: - Public

    func setUserGender(_ gender: UserProfile.Gender) {
      userProfile.gender = gender
    }

    func syncData(completion: @escaping () -> Void) {
      guard shouldUseHealthKitData, let syncGroup = syncGroup else {
        DispatchQueue.main.async(execute: completion)
        return
      }

      syncGroup.notify(queue: .main, execute: { [weak self] in
        self?.userProfile.isSyncedWithHealthKit = true
        completion()
      })
    }
  }
}

// MARK: - Private

private extension GetStarted.ViewModel {

  func resetToDefaults() {
    userProfile = UserProfile()
  }

  func fetchHelthKitDataIfNeeded() {
    let syncGroup = DispatchGroup().with { self.syncGroup = $0 }
    guard shouldUseHealthKitData else {
      resetToDefaults()
      return
    }

    syncGroup.enter()
    authorizeHealthKit { [weak self] succeeded in
      if succeeded {
        self?.fetchHealthKitData(with: syncGroup)
      }
      syncGroup.leave()
    }
  }

  func authorizeHealthKit(completion: @escaping (Bool) -> Void) {
    HealthKitService.instance.authorize { result in
      switch result {
      case .succeeded:
        completion(true)
      case .failed(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }

  func fetchHealthKitData(with syncGroup: DispatchGroup) {
    guard syncGroup == self.syncGroup else { return }

    let healthKit = HealthKitService.instance
    healthKit.gender.with { self.userProfile.gender = $0 }
    healthKit.dateOfBirth.with { self.userProfile.dateOfBirth = $0 }
    syncGroup.enter()
    healthKit.bodyMass { [weak self] bodyMass in
      defer { syncGroup.leave() }
      guard self?.syncGroup == syncGroup, let bodyMass = bodyMass else {
        return
      }

      self?.userProfile.bodyMass = bodyMass
    }

    syncGroup.enter()
    healthKit.height { [weak self] height in
      defer { syncGroup.leave() }
      guard self?.syncGroup == syncGroup, let height = height else {
        return
      }

      self?.userProfile.height = height
    }
  }
}
