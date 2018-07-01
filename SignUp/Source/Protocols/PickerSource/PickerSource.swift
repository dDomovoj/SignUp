//
//  PickerSource.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/1/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

// MARK: - PickerElement

protocol PickerElement: Equatable {

  var title: String { get }
  var attributedTitle: NSAttributedString? { get }
}

extension PickerElement {

  var attributedTitle: NSAttributedString? { return nil }
}

// MARK: - PickerSource

class PickerSource<Element: PickerElement>: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

  typealias Section = [Element]

  var action: (([Element]) -> Void)? { didSet { action?(_selectedItems) } }

  private var _selectedItems: [Element] = []
  var selectedItems: [Element] { return _selectedItems }

  var sections: [Section] = [] { didSet { reloadData() } }
  var pickerView: UIPickerView? { didSet {
    pickerView?.delegate = self
    pickerView?.dataSource = self
    reloadData()
    }
  }

  // MARK: - Public

  func setSelectedItems(_ items: [Element], animated: Bool = false) {
    _selectedItems = items
    guard let pickerView = pickerView,
      items.count == numberOfComponents(in: pickerView) else {
        return
    }

    zip(sections, items).enumerated().forEach { component, element in
      let (section, item) = (element.0, element.1)
      if let index = section.index(of: item) {
        pickerView.selectRow(index, inComponent: component, animated: animated)
      }
    }
  }

  // MARK: - UIPickerViewDataSource

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return sections.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return sections[safe: component]?.count ?? 0
  }

  // MARK: - UIPickerViewDelegate

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    updateSelectedItems()
    action?(_selectedItems)
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return item(for: row, in: component)?.title
  }

  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int,
                  forComponent component: Int) -> NSAttributedString? {
    return item(for: row, in: component).map { $0.attributedTitle } ?? nil
  }
}

// MARK: - Private

private extension PickerSource {

  func item(for row: Int, in component: Int) -> Element? {
    return sections[safe: component]?[safe: row]
  }

  func updateSelectedItems() {
    guard let pickerView = pickerView else { return }

    _selectedItems = (0..<pickerView.numberOfComponents).compactMap { component -> Element? in
      let row = pickerView.selectedRow(inComponent: component)
      let item = sections[safe: component]?[safe: row]
      return item
    }
  }

  func reloadData() {
    pickerView?.reloadAllComponents()
    setSelectedItems(_selectedItems, animated: false)
    action?(_selectedItems)
  }
}
