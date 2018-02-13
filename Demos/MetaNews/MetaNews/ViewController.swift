//
//  ViewController.swift
//  MetaNews
//
//  Created by Sean Thielen on 2/11/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

import UIKit
import Meta

class ViewController: UIViewController {
    let data: [Any] = [
        NewsItem(title: "Jobs: Metaverse is a \"Game Changer\"", image: UIImage(named: "article-jobs.jpg"), url: "https://gometa.io"),
        AdItem(image: UIImage(named: "ad-lumosity.jpg"), experience: "331489cc-d040-4d8d-8594-f23dcfb5654c"),
        NewsItem(title: "A World Where Everyone Can Create Software", image: UIImage(named: "article-ar.jpg"), url: "https://twitter.com/search?f=tweets&vertical=default&q=metaverse%20app&src=typd"),
        NewsItem(title: "How to: Gamify Your Marketing", image: UIImage(named: "article-marketing.jpg"), url: "https://medium.com/@Metaverseapp/gamify-your-marketing-with-interactive-ar-experiences-no-coding-required-28dbb34a218e"),
        AdItem(image: UIImage(named: "ad-lego.jpg"), experience: "13a21a58-3b02-41ee-9a92-57b9953a4b10"),
        NewsItem(title: "Is Your 10 Year Old Really Making Augmented Reality Apps?", image: UIImage(named: "article-kids.jpg"), url: "https://medium.com/metaverseapp/you-can-create-magic-in-the-classroom-951d068f365c"),
    ]

    let headerView = HeaderView()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.frame = self.view.bounds
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        self.tableView.register(AdCell.self, forCellReuseIdentifier: "AdCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)

        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        self.tableView.tableHeaderView = self.headerView
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let newsItem = self.data[indexPath.row] as? NewsItem {
            let titleHeight = NewsCell.computeHeight(data: newsItem, bounds: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
            return (self.view.frame.size.width / 4 * 3) + titleHeight
        } else {
            return 160
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let newsItem = self.data[indexPath.row] as? NewsItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.delegate = self
            cell.update(data: newsItem)
            return cell
        }

        if let adItem = self.data[indexPath.row] as? AdItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath) as! AdCell
            cell.delegate = self
            cell.update(data: adItem)
            return cell
        }

        return UITableViewCell()
    }
}

extension ViewController: NewsCellDelegate, AdCellDelegate {
    func newsCellDidTap(data: NewsItem) {
        let viewController = WebViewController(title: data.title, url: data.url)
        self.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }

    func adCellDidTap(data: AdItem) {
        let experience = MetaExperience(id: data.experience)
        Meta.shared.present(experience: experience)
    }
}
