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

    let viewModel: ViewModel

    // MARK: - Init

    required init(userProfile: UserProfile) {
      viewModel = .init(userProfile: userProfile)
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.TargetWeight.title
      imageView.image = Images.TargetWeight.image.image

      let amount = viewModel.hintTargetWeight()
      let unit = viewModel.hintTargetUnit()
      let unitFull = viewModel.hintTargetUnitFull()
      textLabel.text = L10n.TargetWeight.text(unitFull, "\(amount) \(unit)")

      weightInputView.unitString = unit
      weightInputView.setValue(viewModel.initialTargetWeight())
      weightInputView.valueDidChange = { [weak self] in
        self?.valueDidChange(weight: $0)
      }

      setupActions()
    }
  }
}

// MARK: - Private

private extension TargetWeight.ViewController {

  // MARK: Actions

  func setupActions() {
    button.action = { [weak self] in
      self?.showYourHeight()
    }
  }

  // MARK: Bindings

  // Cold
  func valueDidChange(weight: CGFloat) {
    viewModel.updateWeight(weight)
  }

  // MARK: - Routing

  func showYourHeight() {
    viewModel.syncData { [weak self] error in
      guard let `self` = self else { return }

      if let error = error {
        self.showAlert(title: L10n.Alerts.Titles.error, message: error.localizedDescription)
        return
      }

      let viewController = YourHeight.ViewController(userProfile: self.viewModel.userProfile,
                                                     userTarget: self.viewModel.userTarget)
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}

