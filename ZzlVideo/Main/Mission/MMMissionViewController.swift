//
//  MMMissionViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

class MMMissionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let resquest = AAApiRequest()
    var totalData = Array<MMTaskList>()
    lazy var tableView:UITableView = {
        let table = UITableView()
        table.register(MMMissionTableViewCell.self, forCellReuseIdentifier: "MMMissionTableViewCell")
        table.backgroundColor = UUGlobeGrayBgColor()
        table.showsVerticalScrollIndicator = false
        table.separatorInset = UIEdgeInsets.zero
        table.separatorStyle = .none
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "任務大廳"
        view.backgroundColor = UUGlobeGrayBgColor()
        setUpConfigView()
        getList()
    }
    
    func getList() {
        resquest.taskList { (response) in
            self.totalData = response
            self.tableView.reloadData()
        }
    }
    
    func setUpConfigView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MMMissionTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MMMissionTableViewCell.init(style: .default, reuseIdentifier: "MMMissionTableViewCell")
        let model = totalData[indexPath.row]
        cell.setUpConfigView(titleArray: ["獎勵", "狀態", "操作"], data: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
