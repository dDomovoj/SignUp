//
//  DateOfBirth.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import class Utility.UI

enum DateOfBirth { }

extension DateOfBirth {

  class ViewController: Input.ViewController {

    let button = LargeButton().with { $0.title = L10n.Common.Buttons.next }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubview(button)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.DateOfBirth.title
      imageView.image = Images.DateOfBirth.image.image
      textLabel.text = L10n.DateOfBirth.text
      button.action = { [weak self] in
        let viewController = TargetDailyCalories.ViewController()
        self?.navigationController?.pushViewController(viewController, animated: true)
      }
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      button.pin.bottom().start().end().height(LargeButton.Const.height)
    }
  }
}
