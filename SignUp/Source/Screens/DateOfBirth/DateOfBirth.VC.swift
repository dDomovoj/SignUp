//
//  DateOfBirth.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import class Utility.UI
import class Utility.FormatterPool

enum DateOfBirth { }

extension DateOfBirth {

  class ViewController: Input.ViewController {

    // MARK: - UI

    let inputLabel = Label().with {
      $0.textAlignment = .center
      $0.textColor = Colors.black
      $0.numberOfLines = 1
      $0.font = Fonts.OpenSans.regular.font(size: 48.ui)
    }
    let datePickerView = UIDatePicker().with {
      $0.backgroundColor = Colors.white
      $0.datePickerMode = .date
    }

    // MARK: - Properties

    var date: Date = {
      let minAge: TimeInterval = 13 * 365 * 24 * 60 * 60
      return Date().addingTimeInterval(-minAge)
    }()

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      scrollView.addSubview(inputLabel)
      view.addSubviews(datePickerView)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.DateOfBirth.title
      imageView.image = Images.DateOfBirth.image.image
      textLabel.text = L10n.DateOfBirth.text
      button.action = { [weak self] in
        let viewController = TargetDailyCalories.ViewController()
        self?.navigationController?.pushViewController(viewController, animated: true)
      }

      datePickerView.maximumDate = date
      datePickerView.date = date
      datePickerView.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
      updateDateLabel()
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      layoutLabels()
      datePickerView.pin.bottom(view.pin.safeArea.bottom)
        .start().end()
      button.pin.bottom(to: datePickerView.edge.top)
        .start().end().height(LargeButton.Const.height)
      let bottomInset = datePickerView.bounds.size.height + UI.Const.padding + LargeButton.Const.height
      scrollView.contentInset = .bottom(bottomInset)
      updateContentSize()
    }
  }
}

// MARK: - Private

private extension DateOfBirth.ViewController {

  func layoutLabels() {
    inputLabel.pin.hCenter()
      .top(to: imageView.edge.bottom).marginTop(4.5%)
      .width(70%).sizeToFit(.widthFlexible)
    textLabel.pin.hCenter().maxWidth(75%)
      .top(to: inputLabel.edge.bottom).marginTop(1.5%)
      .sizeToFit(.widthFlexible)
  }

  @objc func dateDidChange(_ sender: UIDatePicker) {
    date = sender.date
    updateDateLabel()
  }

  func updateDateLabel() {
    let locale = Locale.current
    let formatTemplate = "MMM dd yyyy"
    let format = DateFormatter.dateFormat(fromTemplate: formatTemplate, options: 0, locale: locale) ?? formatTemplate
    let formatter = FormatterPool.formatter(DateFormatter.self, format: format, locale: locale)
    inputLabel.text = formatter.string(from: date)
    layoutLabels()
  }
}
