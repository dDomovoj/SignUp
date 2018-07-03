//
//  WIP.VC.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/27/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import PinLayout

import protocol Utility.Flowable

protocol WIPActionRepresentable { }

extension String: WIPActionRepresentable { }

enum WIP {

  typealias BaseViewController = SignUp.ViewController

  fileprivate enum Colors {
    static var tint: UIColor { return SignUp.Colors.black }
  }

  fileprivate enum Fonts {
    static var regular: FontConvertible { return SignUp.Fonts.OpenSans.regular }
  }

  fileprivate enum Images {
    static var cancel: Image { return SignUp.Images.Wip.buttonCancel.image }
    static var underConstruction: Image { return SignUp.Images.Wip.underConstruction.image }
  }
}

// MARK: - Action

extension WIP {

  enum Action {
    case navigation(title: String, () -> UIViewController)
    case presentation(title: String, () -> UIViewController)
    case action(title: String, WIPActionRepresentable)

    var title: String {
      switch self {
      case .navigation(let title, _):
        return title
      case .presentation(let title, _):
        return title
      case .action(let title, _):
        return title
      }
    }
  }
}

// MARK: - ViewController

extension WIP {

  class ViewController: BaseViewController {

    let button = Button().with {
      $0.setImage(Images.cancel.withRenderingMode(.alwaysTemplate), for: .normal)
      $0.tintColor = Colors.tint
    }

    let imageView = ImageView().with {
      $0.backgroundColor = .clear
      $0.contentMode = .scaleAspectFit
      $0.image = Images.underConstruction
    }

    let textLabel = Label().with {
      $0.numberOfLines = 0
      $0.textAlignment = .center
      $0.font = Fonts.regular.font(size: 20.0)
      $0.textColor = Colors.tint
    }

    let actionButton = Button().with {
      $0.setTitle("Click me", for: .normal)
      $0.titleLabel?.font = Fonts.regular.font(size: 20.0)
      $0.setTitleColor(Colors.tint, for: .normal)
    }

    var actions: [Action] = [] { didSet { reloadData() } }

    // MARK: - Init

    convenience init(actions: [Action]) {
      self.init(nibName: nil, bundle: nil)
      self.actions = actions
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
      super.loadView()
      view.backgroundColor = .white
      view.addSubviews([button, imageView, textLabel, actionButton])
      let title = self.title ?? tabBarItem.title ?? navigationItem.title
      let name = title.map { $0.length > 0 ? "\n\n\($0)\n\n" : "" } ?? ""
      textLabel.text = "Ooops... \(name)is under Construction"
      view.setNeedsLayout()

      button.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      button.isHidden = presentingViewController == nil
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      guard !view.bounds.isEmpty else {
        return
      }

      let size = UIScreen.main.bounds.size
      let side = min(size.width, size.height)
      button.pin.size(44.0)
        .top(view.pin.safeArea.top)
        .start(20.ui)
      imageView.pin
        .hCenter()
        .vCenter(to: view.edge.vCenter).marginTop(-view.bounds.size.height * 0.15)
        .width(side * 0.5)
        .aspectRatio()
      textLabel.pin.below(of: imageView, aligned: .center)
        .marginTop(40.ui)
        .width(85%)
        .sizeToFit(.width)
      actionButton.pin.width(75%).bottom(40.ui).height(50.0).hCenter()
    }

    // MARK: - Public

    func didHandleAction(_ action: Action) { print(action) }
  }
}

// MARK: - Private

private extension WIP.ViewController {

  func reloadData() {
    actionButton.isHidden = actions.count < 1
    actionButton.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
  }

  @objc func click(_ sender: UIButton) {
    let actions = self.actions.map { action -> UIAlertAction in
      let alertAction = UIAlertAction(title: action.title, style: .default, handler: { [weak self] _ in
        switch action {
        case .presentation(_, let creator):
          let viewController = creator()
          self?.present(viewController, animated: true, completion: nil)
        case .navigation(_, let creator):
          let viewController = creator()
          self?.navigationController?.pushViewController(viewController, animated: true)
        default: break
        }
        self?.didHandleAction(action)
      })
      return alertAction
    }
    let alert = UIAlertController(title: nil, message: nil,
                                  preferredStyle: actions.count > 1 ? .actionSheet : .alert)
    if UIDevice.current.userInterfaceIdiom == .pad, let popover = alert.popoverPresentationController {
      popover.sourceView = sender
      popover.sourceRect = sender.bounds
    }
    actions.forEach(alert.addAction)
    alert.modalPresentationCapturesStatusBarAppearance = true
    alert.view.tintColor = WIP.Colors.tint
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }

  @objc func dismiss(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
