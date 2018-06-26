//
//  Reusable.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

protocol Reusable {

  associatedtype Data

  static func reuseIdentifier() -> String

  func setup(with data: Data)
}

extension Reusable {

  static func reuseIdentifier() -> String {
    return "\(Mirror(reflecting: self).subjectType)"
  }
}
