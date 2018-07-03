//
//  TargetDailyCaloies.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

extension TargetDailyCalories {

  class ViewModel {

    private(set) var userProfile: UserProfile
    private(set) var userTarget: UserTarget

    // MARK: - Init

    init(userProfile: UserProfile, userTarget: UserTarget) {
      self.userProfile = userProfile
      self.userTarget = userTarget
    }
  }
}

// MARK: - Private

private extension TargetDailyCalories.ViewModel {
  
}
