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

  class ViewController: Input.ViewController {

    let weightInputView = NumericInputView()
    let button = LargeButton().with { $0.title = L10n.Common.Buttons.next }

    private let keyboard = KeyboardObserver()
    private var keyboardHeight: CGFloat?

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubviews(weightInputView, button)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.TargetWeight.title
      imageView.image = Images.TargetWeight.image.image
      textLabel.text = L10n.TargetWeight.text
      button.action = { [weak self] in
        let viewController = YourHeight.ViewController()
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
    }

    // MARK: - Private

    private func handleKeyboardEvents() {
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
}
