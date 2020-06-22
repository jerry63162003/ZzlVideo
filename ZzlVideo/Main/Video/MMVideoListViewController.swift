//
//  MMVideoListViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/25/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import AVKit
import JXSegmentedView
import SJVideoPlayer

class MMVideoListViewController: UIViewController, JXSegmentedListContainerViewListDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var titleTag:MMArticleType? = nil
    var totalData = Array<MMArticle>()
    let resquest = AAApiRequest()
    var currentPage:NSInteger = 1
    var player:AVPlayer? = nil
    var sjPlayer: SJVideoPlayer? = nil
    var selectedIndex:NSInteger = -1
    var cellArr = Array<MMListTableViewCell>()
    
    lazy var tableView:UITableView = {
        let table = UITableView()
        table.register(MMListTableViewCell.self, forCellReuseIdentifier: "MMListTableViewCell")
        table.showsVerticalScrollIndicator = false
        table.separatorInset = UIEdgeInsets.zero
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConfigView()
        getList()
    }
    
    func setUpConfigView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        refreshSetting()
    }
    
    func refreshSetting() {
        tableView.mj_header = UURefreshHeader({
            self.mjHeaderAction()
        })
        tableView.mj_footer = UURefreshFooter({
            self.mjFooterAction()
        })
    }
    
    func mjHeaderAction() {
        currentPage = 1
        totalData.removeAll()
        getList()
    }
    
    func mjFooterAction() {
        if totalData.count > 0 {
            currentPage += 1
        } else {
            currentPage = 1
            totalData.removeAll()
        }
        getList()
    }
    
    func getList() {
        if titleTag == nil {
            return
        }
        resquest.video(sender: ["size":"m", "tag":titleTag?.value ?? "", "per_page":"10", "page": "\(self.currentPage)"]) { (response) in
            self.tableView.mj_header?.endRefreshing()
            for model in response {
                self.totalData.append(model)
            }
            if response.count < 1 {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                self.tableView.mj_footer?.endRefreshing()
            }
            self.tableView.reloadData()
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
                break
            case 1:
                type = .oneImg
                break
            case 3:
                type = .threeImg
                break
            default:
                break
            }
        }
        return type
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = totalData[indexPath.row]
        return MMListTableViewCell.cellHeight(type: getType(model: model))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .singleLine
        let cell = MMListTableViewCell.init(style: .default, reuseIdentifier: "MMListTableViewCell")
        let model = totalData[indexPath.row]
        cell.setUpConfigView(type: getType(model: model), data: model)
        
        cell.sjVideoView.videoCoverView.setUpConfigView(data: model)
        cell.sjVideoView.tag = indexPath.row + 1
        
        cell.sjVideoView.setVideoPlayClickBlock { (isPlaying) in
            cell.sjVideoView.setUpVideoView(data: model, tableView: self.tableView, indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func listView() -> UIView {
        return view
    }
}
