//
//  PagingController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import PinLayout
import Utility

class PagingController<Cell: Reusable & UICollectionViewCell>: ViewController {

  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

  let source = PagingSource<Cell>()

  private var pageObserver: NSKeyValueObservation?
  private(set) var selectedIndex: Int = NSNotFound {
    didSet { if oldValue != selectedIndex { didChangeSelectedIndex?(selectedIndex) } }
  }
  var didChangeSelectedIndex: ((Int) -> Void)?

  // MARK: - Lifecycle

  override func loadView() {
    super.loadView()
    automaticallyAdjustsScrollViewInsets = false
    setupSource()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    updatePageDataWhenNeeded()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.pin.all()
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout).with {
      let bounds = collectionView.bounds.size
      let insets = collectionView.contentInset + $0.sectionInset
      $0.itemSize = CGSize(width: bounds.width - insets.left - insets.right,
                           height: bounds.height - insets.top - insets.bottom)
      $0.invalidateLayout()
    }
  }

  // MARK: - Public

  func collectionViewLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0.0
    layout.minimumInteritemSpacing = 0.0
    return layout
  }

  func setSelectedIndex(_ selectedIndex: Int, animated: Bool = false) {
    let newValue = selectedIndex.clamp(0, source.items.count - 1)
    let pageWidth = collectionView.bounds.size.width
    let targetOffset = CGPoint(x: CGFloat(newValue) * pageWidth, y: 0.0)
    collectionView.setContentOffset(targetOffset, animated: animated)
  }
}

// MARK: - Private

private extension PagingController {

  func setupSource() {
    source.collectionView = collectionView
    if #available(iOS 11.0, *) {
      collectionView.contentInsetAdjustmentBehavior = .never
    }
    collectionView.isPagingEnabled = true
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.bounces = false
    view.addSubviews(collectionView)
  }

  func updatePageDataWhenNeeded() {
    pageObserver = collectionView.observe(\UICollectionView.bounds) { [weak self] _, _ in
      self?.updateSelectedIndexWithCurrentOffset()
    }
  }

  func updateSelectedIndexWithCurrentOffset() {
    let focus = collectionView.bounds.midX
    let index = floor(focus / collectionView.bounds.size.width)
    selectedIndex = Int(index)
  }
}
