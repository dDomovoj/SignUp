//
//  WeightInput.ViewController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import KeyboardObserver
import PinLayout

enum WeightInput { }

extension WeightInput {

  class ViewController: Input.ViewController {

    let weightInputView = NumericInputView()
    let button = LargeButton().with { $0.title = L10n.Common.Buttons.next }

    private let keyboard = KeyboardObserver()
    private var keyboardHeight: CGFloat?

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      scrollView.addSubviews(weightInputView)
      view.addSubviews(button)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      handleKeyboardEvents()
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      _ = weightInputView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      view.endEditing(true)
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
      updateContentSize()
    }
  }
}

// MARK: - Private

private extension WeightInput.ViewController {

  func handleKeyboardEvents() {
    keyboard.observe { [weak self] event -> Void in
      guard let `self` = self else { return }

      let duration = event.duration
      let options = event.options
      UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
        let keyboardHeight = event.keyboardFrameEnd.size.height
        self.keyboardHeight = keyboardHeight
        self.scrollView.contentInset = .bottom(keyboardHeight + LargeButton.Const.height)
        self.view.setNeedsLayout()
      }, completion: nil)
    }
  }
}
