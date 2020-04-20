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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    func listView() -> UIView {
        return view
    }

}
