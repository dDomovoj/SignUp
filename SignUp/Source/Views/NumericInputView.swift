//
//  NumericInputView.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

class NumericInputView: View {

  // MARK: - UI

  let label = Label().with {
    $0.font = Fonts.OpenSans.regular.font(size: 38.ui)
    $0.textColor = Colors.black
    $0.textAlignment = .center
  }
  let underlineView = View().with {
    $0.backgroundColor = Colors.green
  }

  // MARK: - Properties

//  private let numberFormatter = NumberFormatter().with {
//    $0.allowsFloats = true
//    $0.format = .decimal
//    $0.decimalSeparator = "."
//    $0.generatesDecimalNumbers = true
//    $0.maximumFractionDigits = 3
//  }

  var metricsString: String? = "lb" { didSet { update() } }
  private let decimalSeparator = "."
  private var value: CGFloat = 0.0 { didSet { update() } }
  private var inputText = ""

  // MARK: - Overrides

  override var canBecomeFirstResponder: Bool {
    return true
  }

  // MARK: - Lifecycle

  override func setup() {
    super.setup()
    addSubviews(label, underlineView)
    backgroundColor = .clear
    isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
    addGestureRecognizer(tap)
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    update()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.pin.all()
    underlineView.pin.start().end().bottom().height(2.ui)
  }
}

private extension NumericInputView {

  func update() {
    guard superview != nil else { return }

    label.text = displayText()
    setNeedsLayout()
  }
}

// MARK: - UIKeyInput

extension NumericInputView: UIKeyInput {

  var hasText: Bool {
    return inputText.isEmpty
  }

  func insertText(_ text: String) {
    if text == decimalSeparator && inputText.contains(decimalSeparator) { return }

    inputText.append(text)
    update()
  }

  func deleteBackward() {
    guard !inputText.isEmpty else { return }

    _ = inputText.removeLast()
    update()
  }

  @objc dynamic var keyboardType: UIKeyboardType {
    return .decimalPad
  }

  @objc dynamic var keyboardAppearance: UIKeyboardAppearance {
    return .light
  }
}

// MARK: - Private

private extension NumericInputView {

  @objc func tap(_ gesture: UITapGestureRecognizer) {
    _ = becomeFirstResponder()
  }

  func displayText() -> String? {
    let suffix = metricsString.map { " \($0)" } ?? ""
    if inputText.length == 0 {
      return "0" + decimalSeparator + "0" + suffix
    }
    return inputText + suffix
  }
}
