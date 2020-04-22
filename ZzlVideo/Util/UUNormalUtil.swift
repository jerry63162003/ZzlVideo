//
//  UUNormalUtil.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

func UUGlobeRedColor() -> UIColor {
    return UIColor(red:0.82, green:0.33, blue:0.29, alpha:1.0)
}

func UUGlobeGrayColor() -> UIColor {
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

func UUIsiPhoneX() -> Bool {
    return UUStatusBarHeight() > 21
}

func UUBottomHeight() -> CGFloat {
    return ( UUIsiPhoneX() ? 34.0 : 0.0 )
}

func normalFontSize(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size/414 * UUWidth())
}

func boldFontSize(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size/414 * UUWidth())
}

func globeSpace() -> CGFloat {
    return 10 / 414 * UUWidth()
}

func grayTextColor() ->UIColor {
    return UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1.00)
}

func goOustSideSafari(urlStr:String) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
    } else {
        UIApplication.shared.openURL(URL.init(string: urlStr)!)
    }
}
