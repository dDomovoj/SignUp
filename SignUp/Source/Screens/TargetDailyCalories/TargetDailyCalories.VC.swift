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

    private(set) lazy var fromWeightLabel = SmallLabel().with { $0.text = self.viewModel.fromWeight }
    private(set) lazy var toWeightLabel = SmallLabel().with { $0.text = self.viewModel.toWeight }
    let fromDateLabel = SmallLabel().with { $0.text = L10n.TargetDailyCalories.now }
    let toDateLabel = SmallLabel()//.with { $0.text = "by Jun 5" }

    private(set) lazy var weeklyRateView = GenericInputView<WeekRate>().with {
      $0.assignInputView(self.weeklyRatePickerView)
      $0.valueTransform = { $0?.shortTitle ?? "-" }
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
      $0.value = self.viewModel.targetDate
    }

    let targetDateLabel = InputSubtitleLabel().with {
      $0.text = L10n.TargetDailyCalories.targetDate
    }

    private(set) lazy var datePickerView = UIDatePicker().with {
      $0.datePickerMode = .date
      $0.backgroundColor = Colors.white
      $0.date = self.viewModel.targetDate
      $0.minimumDate = self.viewModel.targetDate
      $0.addTarget(self, action: #selector(targetDateDidChange(_:)), for: .valueChanged)
    }

    var finishButton: LargeButton { return button }
    let hideButton = HideButton().with {
      $0.title = L10n.Common.Buttons.hide
    }

    // MARK: - Properties

    let viewModel: ViewModel

    // MARK: - Init

    required init(userProfile: UserProfile, userTarget: UserTarget) {
      viewModel = .init(userProfile: userProfile, userTarget: userTarget)
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      scrollView.addSubview(dailyCaloriesLabel)
      imageView.isHidden = !viewModel.isLosingWeight
      if viewModel.isLosingWeight {
        scrollView.addSubviews(fromDateLabel, fromWeightLabel, toDateLabel, toWeightLabel)
      }
      scrollView.addSubviews(weeklyRateView, weeklyRateLabel, targetDateView, targetDateLabel)
      view.addSubviews(hideButton, finishButton)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.TargetDailyCalories.title
      imageView.image = Images.TargetDailyCalories.graph.image
      button.title = L10n.Common.Buttons.finish
      showText()

      viewModel.source.pickerView = weeklyRatePickerView
      viewModel.didUpdateTargetDate = { [weak self] in
        self?.didUpdateTargetDate(date: $0)
      }
      viewModel.didUpdateDailyCalories = { [weak self] _ in
        self?.didUpdateDailyCalories()
      }
      viewModel.didUpdateWeekRate = { [weak self] weekRate in
        self?.weeklyRateView.value = weekRate
      }
      setupActions()
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      if viewModel.isLosingWeight {
        imageView.pin.hCenter().top(17%)
          .width(394.ui).aspectRatio()
        weeklyRateView.pin.top(to: imageView.edge.bottom).marginTop(5%)
        targetDateView.pin.top(to: imageView.edge.bottom).marginTop(5%)
      } else {
        weeklyRateView.pin.top(17%)
        targetDateView.pin.top(17%)
      }

      weeklyRateView.pin.start(40.ui).width(260.ui)
        .height(45)
      weeklyRateLabel.pin
        .hCenter(to: weeklyRateView.edge.hCenter)
        .top(to: weeklyRateView.edge.bottom).marginTop(2%)
        .width(of: weeklyRateView)
        .sizeToFit(.widthFlexible)
      targetDateView.pin.end(40.ui).width(260.ui)
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
    if viewModel.isLosingWeight {
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
    }
    textLabel.pin
      .hCenter().width(85%)
      .top(to: weeklyRateLabel.edge.bottom).marginTop(7%)
      .sizeToFit(.width)
  }

  func showText() {
    if viewModel.isLosingWeight {
      let normalRate = viewModel.normalRate
      let losingText = L10n.TargetDailyCalories.losingWeightText(normalRate)
      textLabel.text = L10n.TargetDailyCalories.weightText(losingText)
    } else {
      textLabel.text = L10n.TargetDailyCalories.weightText("")
    }
  }

  // MARK: - Bindings

  // Hot
  func didUpdateTargetDate(date: Date) {
    targetDateView.value = date

    let locale = Locale.current
    let formatTemplate = "MMM dd"
    let format = DateFormatter.dateFormat(fromTemplate: formatTemplate, options: 0, locale: locale) ?? formatTemplate
    let formatter = FormatterPool.formatter(DateFormatter.self, format: format, locale: locale)
    toDateLabel.text = L10n.TargetDailyCalories.by + " " + formatter.string(from: date)
    layoutLabels()
  }

  func didUpdateDailyCalories() {
    let formatter = FormatterPool.formatter(NumberFormatter.self, format: NumberFormatter.Format.decimal)
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    let number = NSNumber(value: viewModel.dailyCalories)
    dailyCaloriesLabel.text = formatter.string(from: number)
    layoutLabels()
  }

  // MARK: - Actions

  func setupActions() {
    finishButton.action = { [weak self] in
      self?.viewModel.syncData(completion: { error in
        if let error = error {
          self?.showAlert(title: L10n.Alerts.Titles.error, message: error.localizedDescription)
        } else {
          self?.showAlert(title: L10n.Alerts.Titles.congratulations, message: L10n.Common.finishText)
        }
      })
    }
    hideButton.action = { [weak self] in
      self?.view.endEditing(true)
    }
  }

  @objc func targetDateDidChange(_ sender: UIDatePicker) {
    viewModel.updateTargetDate(sender.date)
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
