//
//  TargetDailyCalories.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import SwiftyAttributes
import class Utility.UI

enum TargetDailyCalories { }

extension TargetDailyCalories {

  class ViewController: Input.ViewController {

    let finishButton = LargeButton().with { $0.title = L10n.Common.Buttons.finish }
    let hideButton = HideButton().with {
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
      imageView.pin.hCenter().top(safeTopGuide).marginTop(3.5%)
        .width(397.ui).aspectRatio()
      hideButton.pin.bottom(view.pin.safeArea.bottom)
        .width(120.ui).end().height(LargeButton.Const.height)
      finishButton.pin.bottom(view.pin.safeArea.bottom)
        .start().end(to: hideButton.edge.start).height(LargeButton.Const.height)
    }
  }
}
