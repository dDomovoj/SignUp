//
//  Welcome.ViewController.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import SwiftyAttributes
import PinLayout
import class Utility.GradientView
import class Utility.UI

enum Welcome {}

extension Welcome {

  class ViewController: SignUp.ViewController {

    typealias Cell = Welcome.PageCell
    typealias Data = Cell.Data

    let pages = Page.all()
    let pagingController = PagingController<Cell>()

    // MARK: - UI

    let containerView = View()
    let topGradientView = GradientView().with {
      $0.direction = .down
      $0.colors = [(0.6, 0.0), (0.0, 1.0)]
        .map { .init(color: Colors.black.withAlphaComponent($0.0), location: $0.1) }
    }
    let bottomGradientView = GradientView().with {
      $0.direction = .up
      $0.colors = [(0.6, 0.0), (0.0, 1.0)]
        .map { .init(color: Colors.black.withAlphaComponent($0.0), location: $0.1) }
    }
    let pageTitleLabel = Label().with {
      $0.numberOfLines = 0
      $0.textAlignment = .center
    }
    let pageTextLabel = Label().with {
      $0.numberOfLines = 0
      $0.textAlignment = .center
    }
    let pageControl = UIPageControl()
    let signUpButton = GreenButton().with {
      $0.title = L10n.Welcome.Buttons.imNew
    }
    let signInButton = GreenButton().with {
      $0.title = L10n.Welcome.Buttons.SignIn.title
      $0.subtitle = L10n.Welcome.Buttons.SignIn.subtitle
    }

    // MARK: - Overrides

    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      automaticallyAdjustsScrollViewInsets = false
      view.backgroundColor = Colors.grayBackgroundBlue
      addSubviews()
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      pagingController.source.items = pages.map { .init(imageUrl: $0.imageUrl) }
      pagingController.didChangeSelectedIndex = { [weak self] in
        self?.updatePageData(at: $0)
      }
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      containerView.pin.all()
      topGradientView.pin.start().end().top().height(30%)
      bottomGradientView.pin.start().end().bottom().height(40%)
      signUpButton.pin
        .bottom(UI.Const.padding + view.pin.safeArea.bottom)
        .start(UI.Const.padding)
        .end(to: view.edge.hCenter).marginEnd(UI.Const.padding * 0.5)
        .height(GreenButton.Const.height)
      signInButton.pin
        .start(to: signUpButton.edge.end).marginStart(UI.Const.padding)
        .bottom(UI.Const.padding + view.pin.safeArea.bottom)
        .end(UI.Const.padding)
        .height(GreenButton.Const.height)
      pageControl.pin
        .hCenter()
        .width(80%).height(44.0)
        .vCenter(to: signInButton.edge.top).marginBottom(42.ui)
      layoutLabels()
    }

    private func layoutLabels() {
      let navBarHeight = navigationController?.navigationBar.bounds.size.height ?? 0.0
      pageTitleLabel.pin.hCenter()
        .top(safeTopGuide - navBarHeight + 40.ui)
        .width(80%)
        .sizeToFit(.widthFlexible)
      pageTextLabel.pin.hCenter().width(85%)
        .bottom(to: signInButton.edge.top).marginBottom(75.ui)
        .sizeToFit(.widthFlexible)
    }
  }
}

// MARK: - Private

private extension Welcome.ViewController {

  func addSubviews() {
    view.addSubview(containerView)
    asContainer().add(pagingController, to: containerView, animated: false)
    view.addSubviews(topGradientView, bottomGradientView)
    view.addSubview(pageControl)
    view.addSubviews(pageTitleLabel, pageTextLabel)
    view.addSubviews(signUpButton, signInButton)
    signInButton.action = { [weak self] in self?.signInButtonTap() }
    signUpButton.action = { [weak self] in self?.registerButtonTap() }
    pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
  }

  // MARK: Action

  @objc func pageControlValueChanged(_ sender: Any?) {
    guard let pageControl = sender as? UIPageControl, pageControl == self.pageControl else {
      return
    }

    pagingController.setSelectedIndex(pageControl.currentPage, animated: true)
  }

  func registerButtonTap() {
    let viewController = GetStarted.ViewController()
    navigationController?.pushViewController(viewController, animated: true)
  }

  func signInButtonTap() {
    let viewController = WIP.ViewController().with { $0.title = L10n.SignIn.title }
    navigationController?.pushViewController(viewController, animated: true)
  }

  // MARK: Update

  func updatePageData(at index: Int) {
    guard let page = pages[safe: index] else {
      return
    }

    pageControl.numberOfPages = pages.count
    pageControl.currentPage = index
    update(title: page.title, with: page.highlight)
    update(text: page.text)
    layoutLabels()
  }

  func update(title: String, with highlight: String?) {
    let attributedTitle = title.uppercased()
      .withFont(Fonts.OpenSans.light.font(size: 58.ui))
      .withTextColor(Colors.white)
    if let highlight = highlight, let range = title.safeRange(of: highlight) {
      let highlightAttribute = Attribute.font(Fonts.OpenSans.semibold.font(size: 58.ui))
      attributedTitle.addAttributes([highlightAttribute], range: range)
    }

    let options = UIViewAnimationOptions.transitionCrossDissolve
    UIView.transition(with: titleLabel, duration: 0.3, options: options, animations: {
      self.pageTitleLabel.attributedText = attributedTitle
    })
  }

  func update(text: String) {
    let attributedText = text
      .withFont(Fonts.OpenSans.regular.font(size: 35.ui))
      .withTextColor(Colors.white)

    let options = UIViewAnimationOptions.transitionCrossDissolve
    UIView.transition(with: pageTextLabel, duration: 0.3, options: options, animations: {
      self.pageTextLabel.attributedText = attributedText
    })
  }
}
