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
      scrollView.addSubview(inputLabel)
      view.addSubviews(datePickerView)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      title = L10n.DateOfBirth.title
      imageView.image = Images.DateOfBirth.image.image
      textLabel.text = L10n.DateOfBirth.text
      datePickerView.maximumDate = viewModel.maximumDate
      datePickerView.minimumDate = viewModel.minimumDate
      datePickerView.date = viewModel.date
      updateDateLabel()
      setupActions()
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

  func updateDateLabel() {
    let locale = Locale.current
    let formatTemplate = "MMM dd yyyy"
    let format = DateFormatter.dateFormat(fromTemplate: formatTemplate, options: 0, locale: locale) ?? formatTemplate
    let formatter = FormatterPool.formatter(DateFormatter.self, format: format, locale: locale)
    inputLabel.text = formatter.string(from: viewModel.date)
    layoutLabels()
  }

  // MARK: - Actions

  func setupActions() {
    datePickerView.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
    button.action = { [weak self] in
      self?.showTargetDailyCalories()
    }
  }

  @objc func dateDidChange(_ sender: UIDatePicker) {
    viewModel.update(dateOfBirth: sender.date)
    updateDateLabel()
  }

  // MARK: - Routing

  func showTargetDailyCalories() {
    viewModel.syncData { [weak self] in
      guard let `self` = self else { return }

      let viewController = TargetDailyCalories.ViewController(userProfile: self.viewModel.userProfile,
                                                              userTarget: self.viewModel.userTarget)
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
