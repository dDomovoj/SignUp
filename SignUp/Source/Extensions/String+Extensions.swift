//
//  String+Extensions.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

extension String {

  func safeRange(of string: String) -> NSRange? {
    guard string.length > 0 else {
      return nil
    }

    let range = (self as NSString).range(of: string)
    guard range.location != NSNotFound, range.length > 0 else {
      return nil
    }

    return range
  }
}
