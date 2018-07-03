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

    let inputLabel = Label().with {
      $0.textAlignment = .center
      $0.textColor = Colors.black
      $0.numberOfLines = 1
      $0.font = Fonts.OpenSans.regular.font(size: 48.ui)
    }
    let pickerView = UIPickerView(frame: .zero).with {
      $0.backgroundColor = Colors.white
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
      view.addSubviews(pickerView)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      viewModel.source.pickerView = pickerView
      title = L10n.YourHeight.title
      imageView.image = Images.Height.image.image
      textLabel.text = L10n.YourHeight.text
      setupActions()
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      layoutLabels()
      pickerView.pin.bottom(view.pin.safeArea.bottom)
      .start().end()
      button.pin.bottom(to: pickerView.edge.top)
        .start().end().height(LargeButton.Const.height)
      let bottomInset = pickerView.bounds.size.height + UI.Const.padding + LargeButton.Const.height
      scrollView.contentInset = .bottom(bottomInset)
      updateContentSize()
    }
  }
}

// MARK: - Private

private extension YourHeight.ViewController {

  func layoutLabels() {
    inputLabel.pin.hCenter()
      .top(to: imageView.edge.bottom).marginTop(4.5%)
      .width(70%).sizeToFit(.widthFlexible)
    textLabel.pin.hCenter().maxWidth(75%)
      .top(to: inputLabel.edge.bottom).marginTop(1.5%)
      .sizeToFit(.widthFlexible)
  }

  // MARK: - Actions

  func setupActions() {
    button.action = { [weak self] in
      self?.showDateOfBirth()
    }
    viewModel.didUpdateHeight = { [weak self] heightText in
      self?.inputLabel.text = heightText
      self?.layoutLabels()
    }
  }

  // MARK: - Routing

  func showDateOfBirth() {
//    let viewController = DateOfBirth.ViewController()
//    self?.navigationController?.pushViewController(viewController, animated: true)
  }
}
