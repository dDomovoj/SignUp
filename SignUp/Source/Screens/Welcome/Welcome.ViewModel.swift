//
//  Welcom.Page.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

extension Welcome {

  class ViewModel {

    let pages: [Page] = [.welcome, .planGoals, .trackFood, .getMotivated, .beHealthy]
  }
}

// MARK: - Page

extension Welcome {

  enum Page: Int {
    case welcome = 0
    case planGoals
    case trackFood
    case getMotivated
    case beHealthy

    var title: String {
      switch self {
      case .welcome: return L10n.Welcome.Paging.First.title
      case .planGoals: return L10n.Welcome.Paging.Second.title
      case .trackFood: return L10n.Welcome.Paging.Third.title
      case .getMotivated: return L10n.Welcome.Paging.Fourth.title
      case .beHealthy: return L10n.Welcome.Paging.Fifth.title
      }
    }

    var highlight: String? {
      if self == .welcome {
        return L10n.Welcome.Paging.First.highlight
      }
      return nil
    }

    var text: String {
      switch self {
      case .welcome: return L10n.Welcome.Paging.First.text
      case .planGoals: return L10n.Welcome.Paging.Second.text
      case .trackFood: return L10n.Welcome.Paging.Third.text
      case .getMotivated: return L10n.Welcome.Paging.Fourth.text
      case .beHealthy: return L10n.Welcome.Paging.Fifth.text
      }
    }

    private static let seed = Int.random()
    var imageUrl: String {
      let seed = type(of: self).seed
      let width = UIScreen.main.bounds.size.width * UIScreen.main.scale
      let height = UIScreen.main.bounds.size.height * UIScreen.main.scale
      let index = abs(seed.multipliedReportingOverflow(by: 1 + rawValue).partialValue) % 1000 + 1
      return "https://picsum.photos/\(width.formatted(".0"))/\(height.formatted(".0"))/?image=\(index)"
    }
  }
}
