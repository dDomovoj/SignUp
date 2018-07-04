//
//  PersistenceService.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

final class PersistenceService {

  private init() {}

  class func storeUserData(userProfile: UserProfile, userTarget: UserTarget,
                          completion: @escaping (Bool) -> Void) {
    // TODO: Implementation (e.g. Codable)
    DispatchQueue.main.async { completion(true) }
  }
}
