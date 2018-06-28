//
//  Input.ViewController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import PinLayout
import UIKit
import class Utility.UI

enum Input { }

extension Input {

  class ViewController: SignUp.ViewController {

    // MARK: - UI

    let backgroundView = BackgroundView()
    let imageView = ImageView().with { $0.contentMode = .scaleAspectFit  }
    let textLabel = Label().with {
      $0.textColor = Colors.grayDarkBlue
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.font = Fonts.OpenSans.regular.font(size: 26.ui)
      $0.text = L10n.GetStarted.text
    }

    // MARK: - Overrides

    override var title: String? {
      get { return titleLabel.text }
      set { titleLabel.text = newValue; titleLabel.sizeToFit() }
    }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubviews(backgroundView, imageView, textLabel)
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      backgroundView.pin.start().top().end().height(50%)
      imageView.pin.hCenter().top(safeTopGuide).marginTop(3.5%)
        .width(210.ui).aspectRatio()
      textLabel.pin.hCenter().maxWidth(75%)
        .top(to: imageView.edge.bottom).marginTop(7%)
        .sizeToFit(.widthFlexible)
    }
  }
}
