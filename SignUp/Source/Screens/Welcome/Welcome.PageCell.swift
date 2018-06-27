//
//  Welcome.PageCell.swift
//  SignUp
//
//  Created by Dmitry Duleba on 6/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import PinLayout
import Kingfisher

extension Welcome {

  class PageCell: Cell, Reusable {

    struct Data {
      let imageUrl: String
    }

    let imageView = ImageView()

    // MARK: - Lifecycle

    override func setup() {
      super.setup()
      contentView.addSubview(imageView)
    }

    override func layoutSubviews() {
      super.layoutSubviews()
      imageView.pin.all()
    }

    override func prepareForReuse() {
      super.prepareForReuse()
      imageView.image = nil
      imageView.kf.cancelDownloadTask()
    }

    // MARK: - Public

    func setup(with data: Data) {
      contentView.backgroundColor = Colors.grayBackgroundBlue
      let url = URL(string: data.imageUrl)
      let fade = ImageTransition.fade(0.3)
      let options: [KingfisherOptionsInfoItem] = [.backgroundDecode, .transition(fade)]
      imageView.kf.setImage(with: url, placeholder: nil, options: options, progressBlock: nil) { _, error, _, url in
        error.with { print("URL: \(url?.absoluteString ?? "unknown") - \($0.localizedDescription)") }
      }
    }
  }
}
