//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Nate Murray on 6/2/14.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import UIKit
import SpriteKit
import Meta

class ViewController: UIViewController {
    let experiences: [String] = [
        "a949aedb-87d7-4999-bb2a-6447a01803eb",
        "a8bb6321-affa-4636-84a4-b3a083b6bbfa",
        "cc4389f5-4e78-4820-b85f-cfe21c3c205d"
    ]

    let scene = SKView()
    var gameScene: GameScene?

    var livesRemaining: Int = 3 {
        didSet {
            self.livesLabel.text = "\(self.livesRemaining) \(self.livesRemaining == 1 ? "life" : "lives") remaining"

            if(self.livesRemaining <= 0) {
                self.gameScene?.canRestart = false
                self.livesLabel.text = "Game Over!"
                self.livesLabel.textColor = .red
                self.showGetMoreLivesButton()
            } else {
                self.gameScene?.canRestart = true
                self.livesLabel.textColor = .white
                self.hideGetMoreLivesButton()
            }
        }
    }

    var livesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        label.text = "3 lives remaining"
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()

    var moreLivesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.alpha = 0
        return button
    }()
    var moreLivesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        label.textAlignment = .center
        label.text = "Play an ad to get 3 more lives"
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scene.frame = self.view.bounds
        self.view.addSubview(self.scene)
        if let gameScene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            self.gameScene = gameScene

            self.scene.ignoresSiblingOrder = true
            gameScene.scaleMode = .aspectFill
            gameScene.interfaceDelegate = self
            self.scene.presentScene(gameScene)
        }

        self.livesLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 140)
        self.view.addSubview(self.livesLabel)

        self.moreLivesButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 4 * 3, height: 72)
        self.moreLivesButton.center = self.view.center
        self.view.addSubview(self.moreLivesButton)
        self.moreLivesButton.addTarget(self, action: #selector(self.didTapGetMoreLives), for: .touchUpInside)

        self.moreLivesLabel.frame = self.moreLivesButton.bounds.insetBy(dx: 4, dy: 4)
        self.moreLivesButton.addSubview(self.moreLivesLabel)
    }

    func showGetMoreLivesButton() {
        UIView.animate(withDuration: 0.2) {
            self.moreLivesButton.alpha = 1
        }
    }

    func hideGetMoreLivesButton() {
        UIView.animate(withDuration: 0.2) {
            self.moreLivesButton.alpha = 0
        }
    }

    @objc func didTapGetMoreLives() {
        let randomIndex = Int(arc4random() % UInt32(self.experiences.count))

        var experience = MetaExperience(id: self.experiences[randomIndex])
        experience.delegate = self
        Meta.shared.present(experience: experience)

        self.hideGetMoreLivesButton()
    }
}

extension ViewController: GameSceneProtocol, MetaExperienceDelegate {
    func gameSceneProtocolDidDie() {
        self.livesRemaining -= 1
    }

    func metaExperienceDidClose(withReason reason: MetaExperienceCloseReason) {
        if(reason == .completion) {
            self.moreLivesLabel.text = "Play an ad to get 3 more lives"
            self.livesRemaining = 3
        } else {
            self.moreLivesLabel.text = "Ad not completed! Try again"
            self.showGetMoreLivesButton()
        }
    }
}
