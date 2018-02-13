//
//  NewsCell.swift
//  MetaNews
//
//  Created by Sean Thielen on 2/11/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    weak var delegate: NewsCellDelegate?
    var data: NewsItem?

    var container = UIButton()
    var innerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()

    var itemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        image.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return image
    }()

    var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        return label
    }()

    static func computeHeight(data: NewsItem, bounds: CGRect) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.text = data.title

        return label.sizeThatFits(bounds.insetBy(dx: 18, dy: 18).size).height + 24
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(self.container)
        self.container.addSubview(self.innerView)

        self.innerView.addSubview(self.itemImage)
        self.innerView.addSubview(self.title)

        self.container.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
    }

    func update(data: NewsItem) {
        self.data = data
        self.title.text = data.title
        self.itemImage.image = data.image
    }

    @objc func didTap() {
        UIView.animate(withDuration: 0.20, animations: {
            self.innerView.transform = CGAffineTransform.identity.scaledBy(x: 0.93, y: 0.93)
        }, completion: { _ in
            if let data = self.data {
                self.delegate?.newsCellDidTap(data: data)
            }

            UIView.animate(withDuration: 0.20, animations: {
                self.innerView.transform = CGAffineTransform.identity
            })
        })

        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.container.frame = self.bounds.insetBy(dx: 18, dy: 18)
        self.innerView.frame = self.container.bounds

        self.itemImage.frame = CGRect(x: 0, y: 0, width: self.innerView.frame.size.width, height: self.innerView.frame.size.width / 4 * 3)
        self.title.frame = CGRect(x: 0, y: self.itemImage.frame.size.height, width: self.innerView.frame.size.width, height: self.innerView.frame.size.height - self.itemImage.frame.size.height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not implemented")
    }
}

protocol NewsCellDelegate: class {
    func newsCellDidTap(data: NewsItem)
}
