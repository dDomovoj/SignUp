//
//  Input.ViewController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/28/18.
//  Copyright © 2018 Home. All rights reserved.
//

import PinLayout
import UIKit
import class Utility.UI

enum Input { }

extension Input {

  class ViewController: SignUp.ViewController {

    // MARK: - UI

    let backgroundView = BackgroundView()
    let scrollView = UIScrollView().with {
      $0.showsVerticalScrollIndicator = false
      $0.showsHorizontalScrollIndicator = false
    }
    let imageView = ImageView().with { $0.contentMode = .scaleAspectFit  }
    let textLabel = Label().with {
      $0.textColor = Colors.grayDarkBlue
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.font = Fonts.OpenSans.regular.font(size: 26.ui)
      $0.text = L10n.GetStarted.text
    }

    // MARK: - Overrides

    override var title: String? {
      get { return titleLabel.text }
      set { titleLabel.text = newValue; titleLabel.sizeToFit() }
    }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.addSubviews(backgroundView, scrollView)
      scrollView.addSubviews(imageView, textLabel)
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      backgroundView.pin.start().top().end().height(50%)
      scrollView.pin.top(safeTopGuide).start().end()
        .bottom(view.pin.safeArea.bottom)
      imageView.pin.hCenter().top().marginTop(3.5%)
        .height(15%).aspectRatio()
//        .width(210.ui)
      textLabel.pin.hCenter().maxWidth(75%)
        .top(to: imageView.edge.bottom).marginTop(7%)
        .sizeToFit(.widthFlexible)
      updateContentSize()
    }

    // MARK: - Public

    func updateContentSize() {
      let maxY = scrollView.subviews
        .map { $0.frame.maxY }
        .max() ?? 0.0
      scrollView.contentSize = CGSize(width: view.bounds.size.width,
                                      height: maxY + UI.Const.padding)
      let realContentHeight = scrollView.contentSize.height
        + scrollView.contentInset.top + scrollView.contentInset.bottom
      scrollView.isScrollEnabled = realContentHeight > scrollView.bounds.size.height
    }
  }
}
