//
//  BBTabbarController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import SnapKit

class BBTabBarController: UITabBarController, UITabBarControllerDelegate {
    let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    let navHome =  BBNavigationController.init(rootViewController: MMHomeViewController.init())
    let navVideo = BBNavigationController.init(rootViewController: MMVideoViewController.init())
    let navTeach = BBNavigationController.init(rootViewController: MMTeachViewController.init())
    let navMission = BBNavigationController.init(rootViewController: MMMissionViewController.init())
    let navAccount = BBNavigationController.init(rootViewController: MMAccountViewController.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCustomNavigation()
        delegate=self
        // iOS 12 have a problem: when you back from another page, there will be a flicker problem.
        self.tabBar.isTranslucent = false
    }
    
    func initCustomNavigation() {
        navHome.tabBarItem = tabBarColorSetting(title: "首頁", image: "ic_home_normal", selectImage: "ic_home_select")
        navVideo.tabBarItem = tabBarColorSetting(title: "視頻", image: "ic_video_normal", selectImage: "ic_video_select")
        navTeach.tabBarItem = tabBarColorSetting(title: "賺賺", image: "ic_teach_normal", selectImage: "ic_teach_select")
        navMission.tabBarItem = tabBarColorSetting(title: "任務", image: "ic_mission_normal", selectImage: "ic_mission_select")
        navAccount.tabBarItem = tabBarColorSetting(title: "我的", image: "ic_account_normal", selectImage: "ic_account_select")
        viewControllers=[navHome,navVideo,navTeach,navMission,navAccount]
    }
    
    func tabBarColorSetting(title:String,image:String,selectImage:String) ->UITabBarItem {
        let tabBar = UITabBarItem.init(title: title, image: UIImage.init(named: image)!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: selectImage)!.withRenderingMode(.alwaysOriginal))
        tabBar.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UUGrayTextColor(), NSAttributedString.Key.font:UIFont.systemFont(ofSize: UUWidth() * 0.03)], for: .normal)
        tabBar.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UUGlobeRedColor(), NSAttributedString.Key.font:UIFont.systemFont(ofSize: UUWidth() * 0.03)], for: .selected)
        
        if UUHeight() > 736 {
            tabBar.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
            tabBar.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: UUHeight() * 0.016)
        } else if UUHeight() == 736 {
            tabBar.imageInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0)
            tabBar.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -UUHeight() * 0.004)
        }
        return tabBar
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isEqual(navVideo) {
            let rotation:UIInterfaceOrientationMask = [.portrait, .landscapeRight, .landscapeLeft]
            kAppdelegate?.blockRotation = rotation
        } else {
            let rotation:UIInterfaceOrientationMask = [.portrait]
            kAppdelegate?.blockRotation = rotation
        }
        return true
    }
}
