//
//  MMHomeSecondViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import JXSegmentedView

class MMHomeSecondViewController: UIViewController, JXSegmentedListContainerViewListDelegate {
    
    var titleTag:MMArticleType? = nil
    let resquest = AAApiRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(titleTag?.value ?? "")
        getList()
    }
    
    func getList() {
        resquest.article(sender: ["size":"m", "tag":titleTag?.value ?? "", "per_page":"10", "page":"1"]) { (response) in
//            print(response)
        }
    }
    
    func listView() -> UIView {
        return view
    }

}
