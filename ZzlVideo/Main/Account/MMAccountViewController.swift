//
//  MMAccountViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

class MMAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let resquest = AAApiRequest()
    lazy var tableView:UITableView = {
        let table = UITableView()
        table.register(MMAccountTableViewCell.self, forCellReuseIdentifier: "MMAccountTableViewCell")
        table.backgroundColor = UUGlobeGrayBgColor()
        table.showsVerticalScrollIndicator = false
        table.separatorInset = UIEdgeInsets.zero
        table.separatorStyle = .none
        table.sectionFooterHeight = 0
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.delegate = self
        table.dataSource = self
        return table
    }()
    let imgNameArr:Array<Array<String>> = [["ic_account_share", "ic_account_invited"], ["ic_account_task", "ic_account_more"]]
    let textArr : Array<Dictionary<String, String>> = [["name":"客服QQ:","content":"859785620"], ["name":"新手學堂","content":"如何賺取更多的錢？"], ["name":"收入榜","content":"大家都賺取了多少？"], ["name":"個人報表","content":"看自己賺取了哪些錢？"], ["name":"個人資料","content":"完善個人訊息"], ["name":"我的好友","content":"哪些好友跟上來我的步伐？"], ["name":"關於我們","content":"了解一下誰給我發錢"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "個人中心"
        setUpConfigView()
    }
    
    func setUpConfigView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return UUGlobeSpace()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView.init(frame: CGRect.init(x: 0, y: 0, width: UUWidth(), height: UUGlobeSpace()))
        }
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return imgNameArr.count
        }
        return textArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MMAccountTableViewCell.cellHeight(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MMAccountTableViewCell.init(style: .default, reuseIdentifier: "MMAccountTableViewCell")
        switch indexPath.section {
        case 0:
            cell.setUpAvatarView(section: indexPath.section)
            break
        case 1:
            let model = imgNameArr[indexPath.row]
            cell.setUpImgBgView(hasSpace: indexPath.row == 0, section: indexPath.section, data: model)
            break
        case 2:
//            tableView.separatorStyle = .singleLine
            if indexPath.row != 0 {cell.accessoryType = .disclosureIndicator}
            let model = textArr[indexPath.row]
            cell.setUpTextView(section: indexPath.section, data: model)
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
