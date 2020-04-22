//
//  MMHomeSecondTableViewCell.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/22/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import Kingfisher

class MMHomeSecondTableViewCell: UITableViewCell {
    
    static func cellHeight(type: ArticleType) -> CGFloat{
        switch type {
        case .ad: return 300
        case .video: return 100
        case .noImg: return 100
        case .oneImg: return 200
        case .threeImg: return 250
        }
    }
    
    var titleLab = UILabel()
    lazy var picImageView:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()
    let sourceLab = UILabel()
    let timeLab = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    func setUpConfigView(type: ArticleType, data: MMArticle) {
        switch type {
        case .ad:
            setUpAdView(data)
            break
        case .video:
            setUpVideoView(data)
            break
        case .noImg:
            setUpNoImgView(data)
            break
        case .oneImg:
            setUpOneImgView(data)
            break
        case .threeImg:
            setUpThreeImgView(data)
            break
        }
    }
    
    func setUpAdView(_ data: MMArticle) {
        backgroundColor = .white
        let width = UUWidth() - 2 * globeSpace()
        let sourceHeight = 14/414*UUWidth() + globeSpace()
        let sourceWidth = 14/414*UUWidth()*2 + globeSpace()
        
        titleLab.text = data.title
        titleLab.font = boldFontSize(20)
        titleLab.numberOfLines = 0
        let labelSize = titleLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(globeSpace())
            make.left.equalToSuperview().offset(globeSpace())
            make.size.equalTo(labelSize)
        }
        for model in data.images ?? [] {
            picImageView.kf.setImage(with: URL.init(string: model.imageUrl ?? ""))
            let spaceCount = (data.images?.count ?? 0) - 1
            let imgWidth = (width - CGFloat(spaceCount) * globeSpace()) / (data.images?.count ?? 0)
            let imgHeight = 300 - labelSize.height - globeSpace()*4 - sourceHeight
            addSubview(picImageView)
            picImageView.snp.makeConstraints { (make) in
                make.left.equalTo(titleLab)
                make.top.equalTo(titleLab.snp.bottom).offset(globeSpace())
                make.size.equalTo(CGSize.init(width: imgWidth, height: imgHeight))
            }
        }
         
        sourceLab.text = "廣告"
        sourceLab.layer.cornerRadius = 4.0
        sourceLab.layer.borderWidth = 1.0
        sourceLab.layer.borderColor = grayTextColor().cgColor
        sourceLab.textColor = grayTextColor()
        sourceLab.font = normalFontSize(14)
        sourceLab.textAlignment = .center
        addSubview(sourceLab)
        sourceLab.snp.makeConstraints { (make) in
            make.top.equalTo(picImageView.snp.bottom).offset(globeSpace())
            make.left.equalTo(titleLab)
            make.width.equalTo(sourceWidth)
            make.height.equalTo(sourceHeight)
        }
        
        timeLab.text = "剛剛"
        timeLab.textColor = grayTextColor()
        timeLab.font = normalFontSize(14)
        addSubview(timeLab)
        timeLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(sourceLab)
            make.left.equalTo(sourceLab.snp.right).offset(globeSpace())
        }
    }
    
    func setUpVideoView(_ data: MMArticle) {
        backgroundColor = .green
    }
    
    func setUpNoImgView(_ data: MMArticle) {
        backgroundColor = .white
        let width = UUWidth() - 2 * globeSpace()
        
        titleLab.text = data.title
        titleLab.font = boldFontSize(20)
        titleLab.numberOfLines = 0
        let labelSize = titleLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(globeSpace())
            make.left.equalToSuperview().offset(globeSpace())
            make.size.equalTo(labelSize)
        }
        
        sourceLab.text = "\(data.sourceName ?? "") \(data.commentsCount ?? 0)觀看 \(data.createdAtHuman ?? "")"
        sourceLab.textColor = grayTextColor()
        sourceLab.font = normalFontSize(14)
        sourceLab.textAlignment = .center
        addSubview(sourceLab)
        sourceLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-globeSpace())
            make.left.equalTo(titleLab)
        }
    }
    
    func setUpOneImgView(_ data: MMArticle) {
        backgroundColor = .blue
    }
    
    func setUpThreeImgView(_ data: MMArticle) {
        backgroundColor = .purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
