//
//  TargetDailyCalories.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import PinLayout
import SwiftyAttributes
import class Utility.UI
import class Utility.FormatterPool

enum TargetDailyCalories { }

extension TargetDailyCalories {

  class ViewController: Input.ViewController {

    // MARK: - UI

    let dailyCaloriesLabel = Label().with {
      $0.font = Fonts.OpenSans.semibold.font(size: 80.ui)
      $0.textAlignment = .center
      $0.numberOfLines = 1
      $0.textColor = Colors.grayDarkBlue
    }

    let fromWeightLabel = SmallLabel().with { $0.text = "220lb" }
    let toWeightLabel = SmallLabel().with { $0.text = "208lb" }
    let fromDateLabel = SmallLabel().with { $0.text = "Now" }
    let toDateLabel = SmallLabel().with { $0.text = "by Jun 5" }

    private(set) lazy var weeklyRateView = GenericInputView<WeekRate>().with {
      $0.assignInputView(self.weeklyRatePickerView)
      $0.valueTransform = { $0?.title ?? "-" }
    }

    let weeklyRateLabel = InputSubtitleLabel().with {
      $0.text = L10n.TargetDailyCalories.weeklyRate
    }

    let weeklyRatePickerView = UIPickerView().with {
      $0.backgroundColor = Colors.white
    }

    private(set) lazy var targetDateView = GenericInputView<Date>().with {
      $0.assignInputView(self.datePickerView)
      $0.valueTransform = { date -> String in
        let locale = Locale.current
        let template = "MMM dd, yyyy"
        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) ?? template
        let dateFormatter = FormatterPool.formatter(DateFormatter.self, format: format, locale: locale)
        return date.map { dateFormatter.string(from: $0) } ?? "-"
      }
      $0.value = Date().addingTimeInterval(28 * 24 * 60 * 60)
    }

    let targetDateLabel = InputSubtitleLabel().with {
      $0.text = L10n.TargetDailyCalories.targetDate
    }

    private(set) lazy var datePickerView = UIDatePicker().with {
      $0.datePickerMode = .date
      $0.backgroundColor = Colors.white
      $0.date = Date().addingTimeInterval(28 * 24 * 60 * 60)
      $0.minimumDate = Date().addingTimeInterval(28 * 24 * 60 * 60)
      $0.addTarget(self, action: #selector(targetDateDidChange(_:)), for: .valueChanged)
    }

    var finishButton: LargeButton { return button }
    let hideButton = HideButton().with {
      $0.title = L10n.Common.Buttons.hide
    }

    // MARK: - Properties

    private let pickerSource = Source()

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      scrollView.addSubviews(dailyCaloriesLabel,
                             fromDateLabel, fromWeightLabel, toDateLabel, toWeightLabel,
                             weeklyRateView, weeklyRateLabel, targetDateView, targetDateLabel)
      view.addSubviews(hideButton, finishButton)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.TargetDailyCalories.title
      imageView.image = Images.TargetDailyCalories.graph.image
      button.title = L10n.Common.Buttons.finish
      showText()
      updateDailyCaloriesCount()

      pickerSource.pickerView = weeklyRatePickerView
      pickerSource.action = { [weak self] in
        self?.weeklyRateView.value = $0.first
      }
      finishButton.action = { [weak self] in
        self?.showAlert(title: L10n.Alerts.Titles.congratulations, message: L10n.Common.finishText)
      }
      hideButton.action = { [weak self] in
        self?.view.endEditing(true)
      }
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      imageView.pin.hCenter().top(17%)
        .width(394.ui).aspectRatio()
      weeklyRateView.pin.start(40.ui).width(260.ui)
        .top(to: imageView.edge.bottom).marginTop(5%)
        .height(45)
      weeklyRateLabel.pin
        .hCenter(to: weeklyRateView.edge.hCenter)
        .top(to: weeklyRateView.edge.bottom).marginTop(2%)
        .width(of: weeklyRateView)
        .sizeToFit(.widthFlexible)
      targetDateView.pin.end(40.ui).width(260.ui)
        .top(to: imageView.edge.bottom).marginTop(5%)
        .height(45)
      targetDateLabel.pin
        .hCenter(to: targetDateView.edge.hCenter)
        .top(to: weeklyRateView.edge.bottom).marginTop(2%)
        .width(of: targetDateView)
        .sizeToFit(.widthFlexible)

      let inputHeight = inputViewHeight
      scrollView.contentInset = .bottom(inputHeight + LargeButton.Const.height)
      let bottom = isInputViewHidden ? view.pin.safeArea.bottom : inputHeight
      let hideEnd = isInputViewHidden ? -120.ui : 0.0
      hideButton.pin.bottom(bottom)
        .width(120.ui).end(hideEnd).height(LargeButton.Const.height)
      finishButton.pin.bottom(bottom)
        .start().end(to: hideButton.edge.start).height(LargeButton.Const.height)
      layoutLabels()
      updateContentSize()
    }
  }
}

// MARK: - Private

private extension TargetDailyCalories.ViewController {

  func layoutLabels() {
    dailyCaloriesLabel.pin.top(2%)
      .hCenter().width(75%)
      .sizeToFit(.widthFlexible)
    fromWeightLabel.pin
      .hCenter(to: imageView.edge.left).marginLeft(116.ui)
      .vCenter(to: imageView.edge.top).marginTop(2.ui)
      .height(fromWeightLabel.font.pointSize)
      .sizeToFit(.widthFlexible)
    fromDateLabel.pin
      .hCenter(to: fromWeightLabel.edge.hCenter)
      .top(to: imageView.edge.bottom).marginTop(5.ui)
      .height(fromDateLabel.font.pointSize)
      .sizeToFit(.widthFlexible)
    toWeightLabel.pin
      .bottom(to: imageView.edge.bottom).marginBottom(21.ui)
      .right(to: imageView.edge.right).marginRight(37.ui)
      .height(toWeightLabel.font.pointSize)
      .sizeToFit(.widthFlexible)
    toDateLabel.pin
      .vCenter(to: fromDateLabel.edge.vCenter)
      .hCenter(to: toWeightLabel.edge.hCenter)
      .height(toDateLabel.font.pointSize)
      .sizeToFit(.widthFlexible)
    textLabel.pin
      .hCenter().width(85%)
      .top(to: weeklyRateLabel.edge.bottom).marginTop(7%)
      .sizeToFit(.width)
  }

  func showText() {
    let isLoosingWeight = true
    if isLoosingWeight {
      let weightPerWeek = "1 \(L10n.Common.Metrics.Weight.pounds)/\(L10n.Common.Metrics.Time.week)"
      let losingText = L10n.TargetDailyCalories.losingWeightText(weightPerWeek)
      textLabel.text = L10n.TargetDailyCalories.weightText(losingText)
    } else {
      textLabel.text = L10n.TargetDailyCalories.weightText("")
    }
  }

  func updateDailyCaloriesCount() {
    let formatter = FormatterPool.formatter(NumberFormatter.self, format: NumberFormatter.Format.decimal)
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    let number = NSNumber(value: 1954)
    dailyCaloriesLabel.text = formatter.string(from: number)
  }

  // MARK: - Action

  @objc func targetDateDidChange(_ sender: UIDatePicker) {
    targetDateView.value = sender.date
  }
}

// MARK: - InputSubtitleLabel

extension TargetDailyCalories {

  class InputSubtitleLabel: Label {

    override func setup() {
      super.setup()
      font = Fonts.OpenSans.regular.font(size: 26.ui)
      textAlignment = .center
      numberOfLines = 1
      textColor = Colors.grayDarkBlue
    }
  }
}

// MARK: - Small Label

extension TargetDailyCalories {

  class SmallLabel: Label {

    override func setup() {
      super.setup()
      textColor = Colors.grayMidBlue
      textAlignment = .center
      numberOfLines = 1
      font = Fonts.Roboto.regular.font(size: 20.ui)
    }
  }
}
