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

    let metricsUnitsLabel = Label().with {
      $0.textColor = Colors.black
      $0.numberOfLines = 1
      $0.textAlignment = .left
      $0.font = Fonts.OpenSans.regular.font(size: 28.ui)
      $0.text = L10n.CurrentWeight.useMetricsUnits
    }
    let metricsUnitsSwitch = UISwitch().with { $0.onTintColor = Colors.green }

    override func loadView() {
      super.loadView()
      scrollView.addSubviews(metricsUnitsLabel, metricsUnitsSwitch)
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
