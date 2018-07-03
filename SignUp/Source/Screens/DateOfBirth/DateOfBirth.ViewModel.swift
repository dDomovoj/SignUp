//
//  DateOfBirth.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

extension DateOfBirth {

  class ViewModel {

    let userProfile: UserProfile
    let userTarget: UserTarget

    init(userProfile: UserProfile, userTarget: UserTarget) {
      self.userProfile = userProfile
      self.userTarget = userTarget
    }
  }
}
