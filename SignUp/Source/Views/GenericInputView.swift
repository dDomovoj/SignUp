//
//  GenericInputView.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

class GenericInputView<T: Any>: View {

  // MARK: - UI

  let label = Label().with {
    $0.textAlignment = .center
    $0.font = Fonts.OpenSans.regular.font(size: 38.ui)
    $0.textColor = Colors.black
  }
  let underlineView = View()

  // MARK: - Properties

  var value: T? { didSet { label.text = stringValue(from: value) } }
  var valueTransform: ((T?) -> String?)?
  private var internalInputView: UIView?

  // MARK: - Overrides

  override func setup() {
    super.setup()
    addTapGesture()
    addSubviews(label, underlineView)
    update()
  }

  override var inputView: UIView? {
    return internalInputView
  }

  override var canBecomeFirstResponder: Bool {
    return true
  }

  override func becomeFirstResponder() -> Bool {
    let result = super.becomeFirstResponder()
    update(result)
    return result
  }

  override func resignFirstResponder() -> Bool {
    let result = super.resignFirstResponder()
    update(!result)
    return result
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    underlineView.pin.start().end().bottom().height(2.ui)
    label.pin.start().end()
      .bottom(to: underlineView.edge.top).marginBottom(2.ui)
      .sizeToFit(.width)
  }

  // MARK: - Public

  func stringValue(from value: T?) -> String? {
    return valueTransform?(value)
  }

  func update() {
    update(isFirstResponder)
  }

  func assignInputView(_ inputView: UIView?) {
    internalInputView = inputView
  }

  // MARK: - Action

  @objc private func tap(_ gesture: UITapGestureRecognizer) {
    _ = becomeFirstResponder()
  }
}

// MARK: - Private

private extension GenericInputView {

  func update(_ firstResponder: Bool) {
    underlineView.backgroundColor = firstResponder ? Colors.green : Colors.grayLightBlue
  }

  func addTapGesture() {
    isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
    addGestureRecognizer(tap)
  }
}
