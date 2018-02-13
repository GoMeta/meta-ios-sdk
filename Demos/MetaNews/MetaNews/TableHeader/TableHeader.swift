//
//  TableHeader.swift
//  MetaNews
//
//  Created by Sean Thielen on 2/11/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UIView {
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.textColor = UIColor(red:0.85, green:0.11, blue:0.13, alpha:1.00)
        label.text = "TOP STORIES"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds.insetBy(dx: 18, dy: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not implemented")
    }
}

