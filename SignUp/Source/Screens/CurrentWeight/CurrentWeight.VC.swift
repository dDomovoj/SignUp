//
//  CurrentWeight.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import class Utility.UI
import KeyboardObserver

enum CurrentWeight { }

extension CurrentWeight {

  class ViewController: WeightInput.ViewController {

    // MARK: - UI

    let metricsUnitsLabel = Label().with {
      $0.textColor = Colors.black
      $0.numberOfLines = 1
      $0.textAlignment = .left
      $0.font = Fonts.OpenSans.regular.font(size: 28.ui)
      $0.text = L10n.CurrentWeight.useMetricsUnits
    }
    let metricsUnitsSwitch = UISwitch().with { $0.onTintColor = Colors.green }

    // MARK: - Properties

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

    override func loadView() {
      super.loadView()
      scrollView.addSubviews(metricsUnitsLabel, metricsUnitsSwitch)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.CurrentWeight.title
      imageView.image = Images.CurrentWeight.image.image
      metricsUnitsSwitch.isOn = viewModel.metrics == .metric
      viewModel.metricsDidChange = { [weak self] in
        self?.metricsDidChange(metrics: $0)
      }
      weightInputView.valueDidChange = { [weak self] in
        self?.valueDidChange(weight: $0)
      }
      setupActions()
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      metricsUnitsSwitch.pin
        .top(to: textLabel.edge.bottom).marginTop(25.ui)
        .hCenter(to: view.edge.hCenter).marginStart(160.ui)
      metricsUnitsLabel.pin
        .before(of: metricsUnitsSwitch, aligned: .center)
        .marginEnd(40.ui)
        .start(140.ui)
        .sizeToFit(.widthFlexible)
      updateContentSize()
    }
  }
}

// MARK: - Private

private extension CurrentWeight.ViewController {

  // MARK: Actions

  func setupActions() {
    button.action = { [weak self] in
      self?.showTargetWeight()
    }
    metricsUnitsSwitch.addTarget(self, action: #selector(switchDidChangeValue(_:)), for: .valueChanged)
  }

  @objc func switchDidChangeValue(_ sender: UISwitch) {
    if sender == metricsUnitsSwitch {
      viewModel.metrics = sender.isOn ? .metric : .imperial
    }
  }

  // MARK: Bindings

  // Hot
  func metricsDidChange(metrics: Metrics) {
    let amount = viewModel.hintCurrentWeight()
    let unit = viewModel.hintCurrentUnit()
    weightInputView.unitString = unit
    weightInputView.setValue(viewModel.userProfile.bodyMass.asWeight(from: .metric, to: metrics))

    textLabel.text = L10n.CurrentWeight.text(L10n.Common.Metrics.Weight.poundsFull, "\(amount) \(unit)")
    view.setNeedsLayout()
  }

  // Cold
  func valueDidChange(weight: CGFloat) {
    viewModel.updateWeight(weight)
  }

  // MARK: - Routing

  func showTargetWeight() {
    viewModel.syncData { [weak self] error in
      if let error = error {
        self?.showAlert(title: L10n.Alerts.Titles.error, message: error.localizedDescription)
        return
      }

      let viewController = TargetWeight.ViewController()
      self?.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
