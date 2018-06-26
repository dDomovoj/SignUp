//
//  UIImage+Extensions.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

extension UIImage {

  static func pixel(with color: UIColor) -> UIImage? {
    let size = CGSize(width: 1, height: 1)
    UIGraphicsBeginImageContext(size)
    guard let context = UIGraphicsGetCurrentContext() else {
      return nil
    }

    context.setFillColor(color.cgColor)
    context.fill(CGRect(origin: .zero, size: size))
    defer { UIGraphicsEndImageContext() }
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
