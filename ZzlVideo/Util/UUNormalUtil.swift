//
//  UUNormalUtil.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import MJRefresh

/*
 * Color
 */
func UUGlobePinkColor() -> UIColor {
    return UIColor(red: 0.89, green: 0.29, blue: 0.40, alpha: 1.00)
}

func UUGlobeRedColor() -> UIColor {
    return UIColor(red:0.82, green:0.33, blue:0.29, alpha:1.0)
}

func UUGlobeGrayBgColor() -> UIColor {
    return UIColor.groupTableViewBackground
}

func UUGrayTextColor() ->UIColor {
    return UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1.00)
}

/*
 * Size
 */
func UUWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width;
}

func UUHeight() -> CGFloat{
    return UIScreen.main.bounds.size.height;
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

func UUBottomHeight() -> CGFloat {
    return ( UUIsiPhoneX() ? 34.0 : 0.0 )
}

func UUGlobeSpace() -> CGFloat {
    return 10 / 414 * UUWidth()
}

func UUCalculateSize(_ num: CGFloat) -> CGFloat {
    return num / 414 * UUWidth()
}

/*
 * KeyWindow
 */
func UUKeyWindow() -> UIWindow {
    if #available(iOS 13.0, *) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return keyWindow!
    } else {
        let keyWindow = UIApplication.shared.keyWindow
        return keyWindow!
    }
}

/*
 * Judgment
 */
func UUIsiPhoneX() -> Bool {
    return UUStatusBarHeight() > 21
}

/*
 * Font
 */
func UUNormalFontSize(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: UUCalculateSize(size))
}

func UUBoldFontSize(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: UUCalculateSize(size))
}

/*
 * Go Safari
 */
func UUGoOustSideSafari(urlStr:String) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
    } else {
        UIApplication.shared.openURL(URL.init(string: urlStr)!)
    }
}

/*
 * MJ_Refresh
 */
func UURefreshHeader(_ refreshingBlock: @escaping (() -> ()))->MJRefreshHeader{
    let header = MJRefreshNormalHeader(refreshingBlock: refreshingBlock)
    header.lastUpdatedTimeLabel?.isHidden = true
    header.stateLabel?.isHidden = false
    return header
}

func UURefreshFooter(_ refreshingBlock: @escaping (() -> ()))->MJRefreshFooter{
    let footer = MJRefreshAutoNormalFooter(refreshingBlock: refreshingBlock)
    return footer
}

/*
 * LineView
 */
func hLineView() -> UIView {
    let grayLine = UIView()
    grayLine.backgroundColor = .groupTableViewBackground
    return grayLine
}
