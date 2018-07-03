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

    private(set) var userProfile: UserProfile
    let userTarget: UserTarget

    var maximumDate: Date {
      return Calendar.current.date(byAdding: .year, value: -13, to: Date())
        ?? Date().addingTimeInterval(-13 * .year)
    }
    var minimumDate: Date {
      return Calendar.current.date(byAdding: .year, value: -120, to: Date())
        ?? Date().addingTimeInterval(-120 * .year)
    }

    var date: Date { return userProfile.dateOfBirth }

    // MARK: - Init

    init(userProfile: UserProfile, userTarget: UserTarget) {
      self.userProfile = userProfile
      self.userTarget = userTarget
    }

    // MARK: - Public

    func update(dateOfBirth: Date) {
      userProfile.dateOfBirth = dateOfBirth
    }

    func syncData(completion: @escaping () -> Void) {
      DispatchQueue.main.async(execute: completion)
    }
  }
}
