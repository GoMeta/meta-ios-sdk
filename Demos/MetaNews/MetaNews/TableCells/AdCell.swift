//
//  AdCell.swift
//  MetaNews
//
//  Created by Sean Thielen on 2/11/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

import Foundation
import UIKit

class AdCell: UITableViewCell {
    weak var delegate: AdCellDelegate?
    var data: AdItem?

    var container = UIButton()
    var adImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.container)
        self.container.addSubview(self.adImage)
        self.container.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
    }

    func update(data: AdItem) {
        self.data = data
        self.adImage.image = data.image
    }

    @objc func didTap() {
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
        }

        if let data = self.data {
            self.delegate?.adCellDidTap(data: data)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.container.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - 18)
        self.adImage.frame = self.container.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not implemented")
    }
}

protocol AdCellDelegate: class {
    func adCellDidTap(data: AdItem)
}

