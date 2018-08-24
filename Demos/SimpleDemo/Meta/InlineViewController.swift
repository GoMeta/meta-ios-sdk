//
//  InlineViewController.swift
//  Meta_Example
//
//  Created by Sean Thielen on 8/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Meta

class InlineViewController: UIViewController {
    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.clipsToBounds = true
        return view
    }()

    lazy var experience: MetaExperience = {
        return MetaExperience()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.innerView.frame = CGRect(
            x: 12,
            y: 12,
            width: self.view.frame.size.width - 24,
            height: self.view.frame.size.height - 24
        )
        self.view.addSubview(self.innerView)

        self.experience.view.frame = self.innerView.bounds
        self.innerView.addSubview(self.experience.view)

        self.experience.load(id: "cff4fbc6-f489-4781-a1db-03e37069b206")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.experience.willAppear()
    }
}
