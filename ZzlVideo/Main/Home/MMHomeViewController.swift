//
//  MMHomeViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import JXSegmentedView

class MMHomeViewController: UIViewController, JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
    
    let segmentedView = JXSegmentedView()
    let segmentedDataSource = JXSegmentedTitleDataSource()
    let indicator = JXSegmentedIndicatorLineView()
    var listContainerView : JXSegmentedListContainerView! = nil
    var personalTitles = ["个人统计分析", "个人账变明细", "个人游戏记录"]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.removeFromSuperview()
        setUpConfigView()
    }
    
    func setUpConfigView() {
        view.addSubview(segmentedView)
        segmentedView.backgroundColor = .white
        segmentedView.delegate = self
        segmentedView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.top).offset(UUStatusBarHeight())
            make.height.equalTo(UUHeight() * 0.0558)
        }

        segmentedDataSource.titles = personalTitles
        segmentedDataSource.titleSelectedColor = UUGlobeRedColor()
        segmentedDataSource.titleNormalColor=UIColor.gray
        segmentedDataSource.titleNormalFont=UIFont.systemFont(ofSize: 18)

        indicator.lineStyle = .lengthenOffset
        indicator.indicatorColor = UUGlobeRedColor()
        indicator.indicatorHeight=2
        segmentedDataSource.reloadData(selectedIndex: 0)
        segmentedView.dataSource = segmentedDataSource

        segmentedView.indicators = [indicator]

        listContainerView = JXSegmentedListContainerView.init(dataSource: self)
        view.addSubview(listContainerView)
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
            make.bottom.equalTo(view)
        }
        segmentedView.contentScrollView = listContainerView.scrollView
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        listContainerView.scrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return personalTitles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return MMHomeSecondViewController()
    }
}
