//
//  MMHomeSecondViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import JXSegmentedView

enum ArticleType: NSInteger {
    case ad = 0
    case video = 1
    case noImg = 2
    case oneImg = 3
    case threeImg = 4
}

class MMHomeSecondViewController: UIViewController, JXSegmentedListContainerViewListDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var titleTag:MMArticleType? = nil
    var totalData = Array<MMArticle>()
    let resquest = AAApiRequest()
    
    lazy var tableView:UITableView = {
        let table = UITableView()
        table.register(MMHomeSecondTableViewCell.self, forCellReuseIdentifier: "MMHomeSecondTableViewCell")
        table.showsVerticalScrollIndicator = false
        table.separatorInset = UIEdgeInsets.zero
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getList()
    }
    
    func getList() {
        if titleTag == nil {
            return
        }
        resquest.article(sender: ["size":"m", "tag":titleTag?.value ?? "", "per_page":"10", "page":"1"]) { (response) in
            self.totalData = response
            self.setUpConfigView()
        }
    }
    
    func setUpConfigView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func getType(model: MMArticle) -> ArticleType {
        // viewType: 0->ad 2->video
        var type:ArticleType = .noImg
        if model.viewType == 0 {
            type = .ad
        } else if model.viewType == 2 {
            type = .video
        } else {
            switch model.images?.count {
            case 0:
                type = .noImg
            case 1:
                type = .oneImg
            case 3:
                type = .threeImg
            default: break
            }
        }
        return type
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = totalData[indexPath.row]
        return MMHomeSecondTableViewCell.cellHeight(type: getType(model: model))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MMHomeSecondTableViewCell.init(style: .default, reuseIdentifier: "MMHomeSecondTableViewCell")
        let model = totalData[indexPath.row]
        cell.setUpConfigView(type: getType(model: model), data: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = totalData[indexPath.row]
        let type:ArticleType = getType(model: model)
        var msg = ""
        switch type {
        case .ad:
            goOustSideSafari(urlStr: model.adUrl ?? "")
            return
        case .video:
            msg = "VIDEO"
            break
        case .noImg:
            msg = "NO IMG"
            break
        case .oneImg:
            msg = "ONE IMG"
            break
        case .threeImg:
            msg = "THREE IMG"
            break
        }
        UUShowToast(message: msg, duration: 2.0, position: UUToastPositionDefault)
    }
    
    func listView() -> UIView {
        return view
    }
}
