//
//  YourHeight.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import class Utility.UI

enum YourHeight { }

extension YourHeight {

  class ViewController: Input.ViewController {

    let button = LargeButton().with { $0.title = L10n.Common.Buttons.next }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubview(button)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.YourHeight.title
      imageView.image = Images.Height.image.image
      textLabel.text = L10n.YourHeight.text
      button.action = { [weak self] in
        let viewController = DateOfBirth.ViewController()
        self?.navigationController?.pushViewController(viewController, animated: true)
      }
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      button.pin.bottom(view.pin.safeArea.bottom)
        .start().end().height(LargeButton.Const.height)
    }
  }
}
