//
//  GetStarted.VC.swift
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
    let healthAppDataSwitch = UISwitch().with { $0.onTintColor = Colors.green }
    let adviceLabel = Label().with {
      $0.textColor = Colors.grayDarkBlue
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.font = Fonts.OpenSans.regular.font(size: 22.ui)
      $0.text = L10n.GetStarted.adviceText
    }
    let maleButton = SmallButton().with { $0.title = L10n.GetStarted.Buttons.male }
    let femaleButton = SmallButton().with { $0.title = L10n.GetStarted.Buttons.female }

    // MARK: - Properties

    let viewModel = ViewModel()

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      button.isHidden = true
      view.addSubviews(healthAppDataLabel, healthAppDataSwitch,
                       adviceLabel,
                       maleButton, femaleButton)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.GetStarted.title
      imageView.image = Images.GetStarted.image.image
      textLabel.text = L10n.GetStarted.text
      setupActions()
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

// MARK: - Private

private extension GetStarted.ViewController {

  // MARK: Actions

  func setupActions() {
    healthAppDataSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    maleButton.action = { [weak self] in
      self?.viewModel.setUserGender(.male)
      self?.showCurrentWeight()
    }
    femaleButton.action = { [weak self] in
      self?.viewModel.setUserGender(.female)
      self?.showCurrentWeight()
    }
  }

  @objc func switchValueChanged(_ sender: UISwitch) {
    if sender == healthAppDataSwitch {
      viewModel.shouldUseHealthKitData = healthAppDataSwitch.isOn
    }
  }

  // MARK: - Routing

  func showCurrentWeight() {
    // TODO: exclusive entrance
    viewModel.syncData { [weak self] in
      guard let `self` = self else { return }

      let profile = self.viewModel.userProfile
      let viewController = CurrentWeight.ViewController(userProfile: profile)
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
