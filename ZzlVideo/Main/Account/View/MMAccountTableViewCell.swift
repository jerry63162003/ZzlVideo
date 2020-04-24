//
//  MMAccountTableViewCell.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/24/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

class MMAccountTableViewCell: UITableViewCell {
    
    static func cellHeight(section: Int) -> CGFloat {
        switch section {
        case 0:
            return UUCalculateSize(180)
        case 1:
            return UUCalculateSize(110)
        case 2:
            return UUCalculateSize(60)
        default:
            return UUCalculateSize(70)
        }
    }
    
    let avatarImgView = UIImageView()
    let titleLab = UILabel()
    let subTitleLab = UILabel()
    let moneyLab = UILabel()
    let withdrawBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
    }
    
    func setUpAvatarView(section: Int) {
        let bgImgWidth:CGFloat = UUWidth() - 2 * UUGlobeSpace()
        let bgImgHeight:CGFloat = MMAccountTableViewCell.cellHeight(section: section) * 0.6
        let imgBg = UIImageView()
        imgBg.image = UIImage(named: "ic_account_info_bg")
        addSubview(imgBg)
        imgBg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UUGlobeSpace())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: bgImgWidth, height: bgImgHeight))
        }
        
        let avatarWidth = bgImgHeight * 0.65
        avatarImgView.image = UIImage(named: "ic_account_avatar")
        imgBg.addSubview(avatarImgView)
        avatarImgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(2*UUGlobeSpace())
            make.size.equalTo(CGSize.init(width: avatarWidth, height: avatarWidth))
        }
        
        let labHeight = avatarWidth/2
        titleLab.text = "立即登入"
        titleLab.font = UUNormalFontSize(18)
        titleLab.textColor = .white
        imgBg.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImgView)
            make.left.equalTo(avatarImgView.snp.right).offset(UUGlobeSpace())
            make.height.equalTo(labHeight)
        }
        
        subTitleLab.text = "一鍵分享 輕鬆賺錢"
        subTitleLab.font = UUNormalFontSize(16)
        subTitleLab.textColor = .white
        imgBg.addSubview(subTitleLab)
        subTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom)
            make.left.height.equalTo(titleLab)
        }
        
        let moneyLabHeight = MMAccountTableViewCell.cellHeight(section: section) - bgImgHeight - 3 * UUGlobeSpace()
        let btnWidth = moneyLabHeight * 1.5
        moneyLab.text = "我的資產: 0.00元"
        moneyLab.font = UUNormalFontSize(18)
        addSubview(moneyLab)
        moneyLab.snp.makeConstraints { (make) in
            make.top.equalTo(imgBg.snp.bottom).offset(UUGlobeSpace())
            make.left.equalTo(imgBg)
            make.height.equalTo(moneyLabHeight)
            make.width.equalTo(bgImgWidth - btnWidth)
        }
        
        withdrawBtn.setTitle("提現", for: .normal)
        withdrawBtn.setTitleColor(.white, for: .normal)
        withdrawBtn.titleLabel?.font = UUNormalFontSize(18)
        withdrawBtn.backgroundColor = UUGlobePinkColor()
        withdrawBtn.layer.cornerRadius = 8.0
        addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints { (make) in
            make.right.equalTo(imgBg)
            make.top.equalTo(moneyLab)
            make.height.equalTo(moneyLab)
            make.width.equalTo(btnWidth)
        }
    }
    
    func setUpImgBgView(hasSpace: Bool, section: Int, data: Array<String>) {
        let view = UIView()
        view.backgroundColor = .clear
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(hasSpace ? UUGlobeSpace()/2:0)
            make.centerX.equalToSuperview()
            make.width.equalTo(UUWidth() - 2 * UUGlobeSpace())
        }
        let imgWidth:CGFloat = (UUWidth() - 2 * UUGlobeSpace()) / data.count
        let imgHeight:CGFloat = MMAccountTableViewCell.cellHeight(section: section) - UUGlobeSpace()/2
        for i in 0..<data.count {
            let imgBg = UIImageView()
            imgBg.image = UIImage(named: data[i])
            imgBg.contentMode = .scaleToFill
            view.addSubview(imgBg)
            imgBg.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(imgWidth * CGFloat(i))
                make.size.equalTo(CGSize.init(width: imgWidth, height: imgHeight))
            }
        }
    }
    
    func setUpTextView(section: Int, data: Dictionary<String, String>) {
        titleLab.text = data["name"]
        titleLab.font = UUNormalFontSize(18)
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(UUGlobeSpace())
        }
        
        subTitleLab.text = data["content"]
        subTitleLab.font = UUNormalFontSize(16)
        subTitleLab.textColor = UUGrayTextColor()
        contentView.addSubview(subTitleLab)
        subTitleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-UUGlobeSpace())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
