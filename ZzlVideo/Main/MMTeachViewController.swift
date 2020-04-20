//
//  MMTeachViewController.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

class MMTeachViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.removeFromSuperview()
        view.backgroundColor = .red
        let image = UIImage.init(named: "ic_teach_pic")
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-UUNavigationBarHeight(controller: self) - UUStatusBarHeight())
            make.left.bottom.right.equalToSuperview()
            make.width.equalTo(UUWidth())
        }
        scrollView.addSubview(imageView)
        let width = UUWidth()
        let height = (width / (image?.size.width ?? 0)) * (image?.size.height ?? 0)
        imageView.image = image
        imageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.size.equalTo(CGSize.init(width: width, height: height))
        }
        scrollView.contentSize = CGSize.init(width: width, height: height)
    }
}
