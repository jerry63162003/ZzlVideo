//
//  MMMissionTableViewCell.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/23/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

class MMMissionTableViewCell: UITableViewCell {

    static func cellHeight() -> CGFloat {
        return UUCalculateSize(130)
    }
    
    lazy var titleLab:UILabel = {
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = .white
        lab.font = UUNormalFontSize(16)
        return lab
    }()
    let cardView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    let redView : UIView = {
        let view = UIView()
        view.backgroundColor = UUGlobePinkColor()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UUGlobeGrayBgColor()
    }
    
    func setUpConfigView(titleArray: Array<String>, data: MMTaskList) {
        addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.width.equalTo(UUWidth() - 2 * UUGlobeSpace())
            make.centerX.equalTo(self)
            make.top.equalTo(UUGlobeSpace())
            make.bottom.equalToSuperview()
        }
        
        cardView.addSubview(redView)
        let redHeight:CGFloat = UUCalculateSize(40)
        redView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(redHeight)
        }
        
        titleLab.text = data.title
        redView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(UUGlobeSpace())
            make.right.equalTo(-UUGlobeSpace())
            make.centerY.equalToSuperview()
        }
        
        var lab = UILabel()
        let labSize = CGSize.init(width: (UUWidth() - CGFloat(titleArray.count+1) * UUGlobeSpace()) / CGFloat(titleArray.count), height: (MMMissionTableViewCell.cellHeight() - redHeight - 3 * UUGlobeSpace() - 1) / 2)
        for i in 0..<titleArray.count {
            lab = UILabel()
            lab.text = titleArray[i]
            lab.textAlignment = .center
            lab.font = UUNormalFontSize(14)
            cardView.addSubview(lab)
            lab.snp.makeConstraints { (make) in
                make.top.equalTo(redView.snp.bottom).offset(UUGlobeSpace()/2)
                make.left.equalToSuperview().offset((UUGlobeSpace() + labSize.width) * CGFloat(i))
                make.size.equalTo(labSize)
            }
        }
        
        let hLine = hLineView()
        cardView.addSubview(hLine)
        hLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(lab.snp.bottom).offset(UUGlobeSpace()/2)
            make.height.equalTo(1)
        }
        
        let detailArr = ["¥\(data.money ?? "")", data.stateText, "立即參加"]
        for i in 0..<detailArr.count {
            lab = UILabel()
            lab.text = detailArr[i]
            if i == 1 {
                lab.textColor = UIColor(red: 0.41, green: 0.65, blue: 0.27, alpha: 1.00)
            } else if i == titleArray.count - 1  {
                lab.backgroundColor = UIColor(red: 0.41, green: 0.65, blue: 0.27, alpha: 1.00)
                lab.textColor = .white
                lab.layer.cornerRadius = 4.0
                lab.clipsToBounds = true
            }
            lab.textAlignment = .center
            lab.font = UUNormalFontSize(14)
            cardView.addSubview(lab)
            lab.snp.makeConstraints { (make) in
                make.top.equalTo(hLine.snp.bottom).offset(UUGlobeSpace()/2)
                make.left.equalToSuperview().offset((UUGlobeSpace() + labSize.width) * CGFloat(i))
                if i == titleArray.count - 1 {
                    make.size.equalTo(CGSize.init(width: labSize.width - UUGlobeSpace(), height: labSize.height))
                } else {
                    make.size.equalTo(labSize)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
