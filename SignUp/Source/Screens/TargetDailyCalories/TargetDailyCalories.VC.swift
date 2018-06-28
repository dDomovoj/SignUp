//
//  TargetDailyCalories.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import class Utility.UI

enum TargetDailyCalories { }

extension TargetDailyCalories {

  class ViewController: Input.ViewController {

    let finishButton = LargeButton().with { $0.title = L10n.Common.Buttons.finish }
    let hideButton = LargeButton().with {
      $0.color = Colors.greenDark
      $0.title = L10n.Common.Buttons.hide
    }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubviews(hideButton, finishButton)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.TargetDailyCalories.title
      imageView.image = Images.TargetDailyCalories.image.image
      textLabel.text = nil
      finishButton.action = { print("Finish") }
      hideButton.action = { print("Hide") }
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      hideButton.pin.bottom().width(120.ui).end().height(LargeButton.Const.height)
      finishButton.pin.bottom().start().end(to: hideButton.edge.start).height(LargeButton.Const.height)
    }
  }
}
