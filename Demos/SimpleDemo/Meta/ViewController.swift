//
//  ViewController.swift
//  Meta
//
//  Created by Sean Thielen on 02/10/2018.
//  Copyright (c) 2018 Sean Thielen. All rights reserved.
//

import UIKit
import Meta

class ViewController: UIViewController {

    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red:0.58, green:0.46, blue:0.80, alpha:1.00)
        let title = NSAttributedString(string: "Present experience", attributes: [
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ])
        button.setAttributedTitle(title, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.frame = CGRect(x: self.view.frame.size.width / 6, y: (self.view.frame.size.height - 54) / 2, width: self.view.frame.size.width / 3 * 2, height: 54)
        self.button.addTarget(self, action: #selector(self.presentExperience), for: .touchUpInside)
        self.view.addSubview(self.button)
    }

    @objc func presentExperience() {
        let experience = MetaExperience(id: "cff4fbc6-f489-4781-a1db-03e37069b206")
        Meta.shared.present(experience: experience)
    }
}

