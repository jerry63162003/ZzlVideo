//
//  BBNavigationController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import SnapKit

class BBNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor(red: 0.84, green: 0.35, blue: 0.43, alpha: 1.00)
//        navigationBar.tintColor = UIColor.white
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        navigationBar.barStyle = .black
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        return
    }
}
