//
//  PagingSource.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

class PagingSource<Cell: Reusable & UICollectionViewCell>: NSObject, UICollectionViewDataSource {

  weak var collectionView: UICollectionView? { didSet { bindCollectionView() } }

  var items: [Cell.Data] = [] { didSet { collectionView?.reloadData() } }

  // MARK: - UICollectionViewDataSource

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let id = Cell.reuseIdentifier()
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
    if let cell = cell as? Cell, let item = items[safe: indexPath.item] {
      cell.setup(with: item)
    }
    return cell
  }
}

// MARK: - Private

private extension PagingSource {

  func bindCollectionView() {
    collectionView?.dataSource = self
    collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier())
    collectionView?.reloadData()
  }
}
