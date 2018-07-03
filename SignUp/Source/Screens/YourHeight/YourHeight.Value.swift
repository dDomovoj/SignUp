//
//  YourHeight.Value.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

extension YourHeight {

  struct Value: PickerElement {

    let amount: Int
    let titleFormatter: (Int) -> String

    var title: String {
      return titleFormatter(amount)
    }

    static func == (lhs: YourHeight.Value, rhs: YourHeight.Value) -> Bool {
      return lhs.title == rhs.title
    }
  }
}
