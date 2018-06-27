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

  class ViewController: SignUp.ViewController {

    // MARK: - UI

    let backgroundView = BackgroundView()
    let imageView = ImageView(image: Images.GetStarted.gender.image).with { $0.contentMode = .scaleAspectFit  }
    let textLabel = Label().with {
      $0.textColor = Colors.grayDarkBlue
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.font = Fonts.OpenSans.regular.font(size: 26.ui)
      $0.text = L10n.GetStarted.text
    }
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
    let maleButton = GreenButton().with { $0.title = L10n.GetStarted.Buttons.male }
    let femaleButton = GreenButton().with { $0.title = L10n.GetStarted.Buttons.female }

    // MARK: - Lifecycle

    override func viewDidLoad() {
      super.viewDidLoad()
      titleLabel.text = L10n.GetStarted.title
      titleLabel.sizeToFit()
    }

    override func loadView() {
      super.loadView()
      view.addSubviews(backgroundView, imageView,
                       textLabel,
                       healthAppDataLabel, healthAppDataSwitch,
                       adviceLabel,
                       maleButton, femaleButton)
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      backgroundView.pin.start().top().end().height(50%)
      imageView.pin.hCenter().top(safeTopGuide).marginTop(3.5%)
        .width(210.ui).aspectRatio()
      textLabel.pin.hCenter().maxWidth(75%)
        .top(to: imageView.edge.bottom).marginTop(7%)
        .sizeToFit(.widthFlexible)
      maleButton.pin
        .bottom(view.pin.safeArea.bottom + UI.Const.padding)
        .start(UI.Const.padding)
        .end(to: view.edge.hCenter).marginEnd(UI.Const.padding * 0.5)
        .height(GreenButton.Const.height)
      femaleButton.pin
        .bottom(view.pin.safeArea.bottom + UI.Const.padding)
        .end(UI.Const.padding)
        .start(to: view.edge.hCenter).marginStart(UI.Const.padding * 0.5)
        .height(GreenButton.Const.height)
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
