//
//  TargetWeight.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import PinLayout
import class Utility.UI
import KeyboardObserver

enum TargetWeight { }

extension TargetWeight {

  class ViewController: WeightInput.ViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.TargetWeight.title
      imageView.image = Images.TargetWeight.image.image
      textLabel.text = L10n.TargetWeight.text
      button.action = { [weak self] in
        let viewController = YourHeight.ViewController()
        self?.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
}
