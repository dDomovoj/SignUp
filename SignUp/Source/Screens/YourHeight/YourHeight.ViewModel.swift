//
//  YourHeight.ViewModel.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/4/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

extension YourHeight {

  class ViewModel {

    let userProfile: UserProfile
    let userTarget: UserTarget
    let source = Source()

    var didUpdateHeight: ((String) -> Void)? { didSet { didUpdateHeight?(heightStringValue()) } }

    // MARK: - Init

    init(userProfile: UserProfile, userTarget: UserTarget) {
      self.userProfile = userProfile
      self.userTarget = userTarget
      setup()
    }
  }
}

private extension YourHeight.ViewModel {

  func setup() {
    source.action = { [weak self] _ in
      guard let `self` = self else { return }

      self.didUpdateHeight?(self.heightStringValue())
    }
  }

  func heightStringValue() -> String {
    return source.selectedItems.reduce("") { $0 + " \($1.title)" }
  }
}
