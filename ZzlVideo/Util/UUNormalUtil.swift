//
//  UUNormalUtil.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

func UUGlobeRedColor() -> UIColor {
    return UIColor(red: 0.34, green: 0.38, blue: 0.43, alpha: 1.00)
}

func UUWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width;
}

func UUHeight() ->CGFloat{
    return UIScreen.main.bounds.size.height;
}

func UUKeyWindow() -> UIWindow {
    if #available(iOS 13.0, *) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return keyWindow!
    } else {
        let keyWindow = UIApplication.shared.keyWindow
        return keyWindow!
    }
}

func UUStatusBarHeight() -> CGFloat {
    var height:CGFloat = 0.0
    if #available(iOS 13.0, *) {
        height = UUKeyWindow().windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    else {
        height = UIApplication.shared.statusBarFrame.height
    }
    return height
}

func UUNavigationBarHeight(controller: UIViewController) -> CGFloat {
    return controller.navigationController?.navigationBar.frame.size.height ?? 0
}
