//
//  ViewController.swift
//  MetaXCX
//
//  Created by Sean Thielen on 2/12/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

import UIKit
import Meta

class LinkButton: UIButton {
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 42)
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()

    init(text: String) {
        super.init(frame: .zero)
        self.addSubview(self.label)
        self.label.text = text
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
        self.label.frame.origin = .zero
        self.label.frame.size.width += 18
        self.label.frame.size.height = self.bounds.size.height
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not implemented")
    }
}

class ViewController: UIViewController {
    var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "charli.jpg")
        return image
    }()

    let container = UIView()
    let trivia = LinkButton(text: "DAILY GAME")
    let news = LinkButton(text: "NEWS")
    let listen = LinkButton(text: "LISTEN")
    let tour = LinkButton(text: "TOUR")
    let insta = LinkButton(text: "INSTA")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundImage.frame = self.view.bounds
        self.view.addSubview(self.backgroundImage)

        self.container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3 * 2, height: 0)
        self.view.addSubview(self.container)

        var yOffset: CGFloat = 0
        let height: CGFloat = 52
        let padding: CGFloat = 6

        self.trivia.frame = CGRect(x: 0, y: yOffset, width: self.container.frame.size.width, height: height)
        self.container.addSubview(self.trivia)
        yOffset += height + padding

        self.news.frame = CGRect(x: 0, y: yOffset, width: self.container.frame.size.width, height: height)
        self.container.addSubview(self.news)
        yOffset += height + padding

        self.listen.frame = CGRect(x: 0, y: yOffset, width: self.container.frame.size.width, height: height)
        self.container.addSubview(self.listen)
        yOffset += height + padding

        self.tour.frame = CGRect(x: 0, y: yOffset, width: self.container.frame.size.width, height: height)
        self.container.addSubview(self.tour)
        yOffset += height + padding

        self.insta.frame = CGRect(x: 0, y: yOffset, width: self.container.frame.size.width, height: height)
        self.container.addSubview(self.insta)
        yOffset += height + padding

        // Update container height
        self.container.frame.size.height = yOffset
        self.container.center = self.view.center

        self.trivia.addTarget(self, action: #selector(self.didTapTrivia), for: .touchUpInside)
        self.news.addTarget(self, action: #selector(self.didTapNews), for: .touchUpInside)
        self.listen.addTarget(self, action: #selector(self.didTapListen), for: .touchUpInside)
        self.tour.addTarget(self, action: #selector(self.didTapTour), for: .touchUpInside)
        self.insta.addTarget(self, action: #selector(self.didTapInsta), for: .touchUpInside)
    }

    @objc func didTapTrivia() {
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
            }
        }

        let experience = MetaExperience(id: "93cf6a9b-2ebd-4f62-9518-2a820bf35093")
        Meta.shared.present(experience: experience)
    }

    @objc func didTapNews() {
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
            }
        }

        let viewController = WebViewController(title: "News", url: "https://twitter.com/charli_xcx")
        self.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }

    @objc func didTapListen() {
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
            }
        }

        let viewController = WebViewController(title: "Listen", url: "https://open.spotify.com/artist/25uiPmTg16RbhZWAqwLBy5")
        self.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }

    @objc func didTapTour() {
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
            }
        }

        let viewController = WebViewController(title: "Tour", url: "https://www.songkick.com/artists/2274326-charli-xcx")
        self.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }

    @objc func didTapInsta() {
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium).impactOccurred()
            }
        }

        let viewController = WebViewController(title: "Insta", url: "https://www.instagram.com/charli_xcx/?hl=en")
        self.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
}

