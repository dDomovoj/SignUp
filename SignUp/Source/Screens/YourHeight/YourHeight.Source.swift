//
//  YourHeight.Source.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

extension YourHeight {

  enum Value: PickerElement {

    case feet(Int)
    case inches(Int)

    var title: String {
      switch self {
      case .feet(let feet):
        if feet == 1 {
          return "1 Foot"
        }
        return "\(feet) Feet"
      case .inches(let inches):
        if inches == 1 {
          return "1 Inch"
        }
        return "\(inches) Inches"
      }
    }
  }

  class Source: PickerSource<Value> {

    override init() {
      super.init()
      let feet = (1...7).map { Value.feet($0) }
      let inches = (0...11).map { Value.inches($0) }
      sections = [feet, inches]
      setSelectedItems([.feet(6), .inches(0)])
    }
  }
}
