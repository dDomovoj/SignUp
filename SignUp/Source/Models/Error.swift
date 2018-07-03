//
//  Errors.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
  
  case tooLightWeight
  case tooHeavyWeight
  case tooLowHeight
  case tooHighHeight

  var localizedDescription: String {
    switch self {
    case .tooHeavyWeight: return L10n.Error.tooHeavyWeight
    case .tooLightWeight: return L10n.Error.tooLightWeight
    case .tooLowHeight: return L10n.Error.tooLowHeight
    case .tooHighHeight: return L10n.Error.tooHighHeight
    }
  }
}
