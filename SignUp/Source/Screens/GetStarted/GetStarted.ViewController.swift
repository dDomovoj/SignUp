//
//  GetStarted.ViewController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import class Utility.UI

enum GetStarted { }

extension GetStarted {

  class ViewController: Input.ViewController {

    // MARK: - UI

    let healthAppDataLabel = Label().with {
      $0.textColor = Colors.black
      $0.numberOfLines = 1
      $0.textAlignment = .left
      $0.font = Fonts.OpenSans.regular.font(size: 28.ui)
      $0.text = L10n.GetStarted.healthAppDataUsage
    }
    let healthAppDataSwitch = UISwitch()
    let adviceLabel = Label().with {
      $0.textColor = Colors.grayDarkBlue
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.font = Fonts.OpenSans.regular.font(size: 22.ui)
      $0.text = L10n.GetStarted.adviceText
    }
    let maleButton = SmallButton().with { $0.title = L10n.GetStarted.Buttons.male }
    let femaleButton = SmallButton().with { $0.title = L10n.GetStarted.Buttons.female }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubviews(healthAppDataLabel, healthAppDataSwitch,
                       adviceLabel,
                       maleButton, femaleButton)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.GetStarted.title
      imageView.image = Images.GetStarted.image.image
      textLabel.text = L10n.GetStarted.text
      maleButton.action = { [weak self] in
        let viewController = CurrentWeight.ViewController()
        self?.navigationController?.pushViewController(viewController, animated: true)
      }
      femaleButton.action = maleButton.action
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      textLabel.pin.hCenter().maxWidth(75%)
        .top(to: imageView.edge.bottom).marginTop(7%)
        .sizeToFit(.widthFlexible)
      maleButton.pin
        .bottom(view.pin.safeArea.bottom + UI.Const.padding)
        .start(UI.Const.padding)
        .end(to: view.edge.hCenter).marginEnd(UI.Const.padding * 0.5)
        .height(SmallButton.Const.height)
      femaleButton.pin
        .bottom(view.pin.safeArea.bottom + UI.Const.padding)
        .end(UI.Const.padding)
        .start(to: view.edge.hCenter).marginStart(UI.Const.padding * 0.5)
        .height(SmallButton.Const.height)
      adviceLabel.pin.hCenter().maxWidth(85%)
        .above(of: maleButton).marginBottom(8.5%)
        .sizeToFit(.widthFlexible)
      healthAppDataSwitch.pin
        .bottom(to: adviceLabel.edge.top).marginBottom(25.ui)
        .hCenter(to: view.edge.hCenter).marginStart(160.ui)
      healthAppDataLabel.pin
        .before(of: healthAppDataSwitch, aligned: .center)
        .marginEnd(40.ui)
        .start(140.ui)
        .sizeToFit(.widthFlexible)
    }
  }
}
