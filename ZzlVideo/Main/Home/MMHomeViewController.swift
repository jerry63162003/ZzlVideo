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
    var personalTitles:Array<String> = []
    var selectedIndex = 0
    var listArr:Array<MMArticleType> = []
    let resquest = AAApiRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.removeFromSuperview()
        getTitleList()
    }
    
    func getTitleList() {
        resquest.articleType { (response) in
            self.listArr = response
            self.setUpConfigView()
        }
    }
    
    func setUpConfigView() {
        for list in self.listArr {
            personalTitles.append(list.text ?? "")
        }
        view.addSubview(segmentedView)
        segmentedView.backgroundColor = .white
        segmentedView.delegate = self
        segmentedView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.top).offset(UUStatusBarHeight())
            make.height.equalTo(UUCalculateSize(50))
        }

        segmentedDataSource.titles = personalTitles
        segmentedDataSource.titleSelectedColor = UUGlobeRedColor()
        segmentedDataSource.titleNormalColor = UIColor.gray
        segmentedDataSource.titleNormalFont = UUNormalFontSize(18)

        indicator.lineStyle = .lengthenOffset
        indicator.indicatorColor = UUGlobeRedColor()
        indicator.indicatorHeight = 2
        segmentedDataSource.reloadData(selectedIndex: 0)
        segmentedView.dataSource = segmentedDataSource
        segmentedView.indicators = [indicator]
        
        let hLine = hLineView()
        view.addSubview(hLine)
        hLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
            make.height.equalTo(1)
        }
        
        listContainerView = JXSegmentedListContainerView.init(dataSource: self)
        view.addSubview(listContainerView)
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(hLine.snp.bottom)
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
        let vc = MMHomeListViewController()
        vc.titleTag = listArr[index]
        return vc
    }
}
