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

  class ViewController: Input.ViewController {

    let weightInputView = NumericInputView()
    let metricsUnitsLabel = Label().with {
      $0.textColor = Colors.black
      $0.numberOfLines = 1
      $0.textAlignment = .left
      $0.font = Fonts.OpenSans.regular.font(size: 28.ui)
      $0.text = L10n.CurrentWeight.useMetricsUnits
    }
    let metricsUnitsSwitch = UISwitch().with { $0.onTintColor = Colors.green }
    let button = LargeButton().with { $0.title = L10n.Common.Buttons.next }

    private let keyboard = KeyboardObserver()
    private var keyboardHeight: CGFloat?

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubviews(weightInputView,
                       metricsUnitsLabel, metricsUnitsSwitch,
                       button)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.CurrentWeight.title
      imageView.image = Images.CurrentWeight.image.image
      textLabel.text = L10n.CurrentWeight.text
      button.action = { [weak self] in
        let viewController = TargetWeight.ViewController()
        self?.navigationController?.pushViewController(viewController, animated: true)
      }
      handleKeyboardEvents()
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      _ = weightInputView.becomeFirstResponder()
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      weightInputView.pin.hCenter().width(260.ui)
        .height(50)
        .top(to: imageView.edge.bottom).marginTop(5%)
      textLabel.pin.top(to: weightInputView.edge.bottom).marginTop(3.5%)
      button.pin
        .bottom(keyboardHeight ?? view.pin.safeArea.bottom)
        .start().end().height(LargeButton.Const.height)
      metricsUnitsSwitch.pin
        .top(to: textLabel.edge.bottom).marginTop(25.ui)
        .hCenter(to: view.edge.hCenter).marginStart(160.ui)
      metricsUnitsLabel.pin
        .before(of: metricsUnitsSwitch, aligned: .center)
        .marginEnd(40.ui)
        .start(140.ui)
        .sizeToFit(.widthFlexible)
    }
  }
}

// MARK: - Private

private extension CurrentWeight.ViewController {

  func handleKeyboardEvents() {
    keyboard.observe { [weak self] event -> Void in
      guard let `self` = self else { return }

      let duration = event.duration
      let options = event.options
      UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
        self.keyboardHeight = event.keyboardFrameEnd.size.height
        self.view.setNeedsLayout()
      }, completion: nil)
    }
  }
}
