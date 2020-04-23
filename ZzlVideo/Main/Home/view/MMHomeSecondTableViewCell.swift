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
        case .ad: return UUCalculateSize(300)
        case .video: return UUCalculateSize(100)
        case .noImg: return UUCalculateSize(100)
        case .oneImg: return UUCalculateSize(150)
        case .threeImg: return UUCalculateSize(220)
        }
    }
    
    var titleLab = UILabel()
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
        let width = UUWidth() - 2 * UUGlobeSpace()
        let sourceHeight = UUCalculateSize(14) + UUGlobeSpace()
        let sourceWidth = UUCalculateSize(14) * 2 + UUGlobeSpace()
        
        titleLab.text = data.title
        titleLab.font = UUBoldFontSize(20)
        titleLab.numberOfLines = 0
        let labelSize = titleLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UUGlobeSpace())
            make.left.equalToSuperview().offset(UUGlobeSpace())
            make.size.equalTo(labelSize)
        }
        
        var picImageView = UIImageView()
        for i in 0..<(data.images?.count ?? 0) {
            let model = data.images?[i]
            
            picImageView = UIImageView()
            picImageView.layer.cornerRadius = 8.0
            picImageView.clipsToBounds = true
            picImageView.kf.setImage(with: URL.init(string: model?.imageUrl ?? ""))
            let spaceCount = (data.images?.count ?? 0) - 1
            let imgWidth = (width - CGFloat(spaceCount) * UUGlobeSpace()) / (data.images?.count ?? 0)
            let imgHeight = MMHomeSecondTableViewCell.cellHeight(type: .ad) - labelSize.height - UUGlobeSpace()*4 - sourceHeight
            let leftSpace = CGFloat(i) * (UUGlobeSpace() + imgWidth)
            addSubview(picImageView)
            picImageView.snp.makeConstraints { (make) in
                make.left.equalTo(titleLab).offset(leftSpace)
                make.top.equalTo(titleLab.snp.bottom).offset(UUGlobeSpace())
                make.size.equalTo(CGSize.init(width: imgWidth, height: imgHeight))
            }
        }
        
        sourceLab.text = "廣告"
        sourceLab.layer.cornerRadius = 4.0
        sourceLab.layer.borderWidth = 1.0
        sourceLab.layer.borderColor = UUGrayTextColor().cgColor
        sourceLab.textColor = UUGrayTextColor()
        sourceLab.font = UUNormalFontSize(14)
        sourceLab.textAlignment = .center
        addSubview(sourceLab)
        sourceLab.snp.makeConstraints { (make) in
            make.top.equalTo(picImageView.snp.bottom).offset(UUGlobeSpace())
            make.left.equalTo(titleLab)
            make.width.equalTo(sourceWidth)
            make.height.equalTo(sourceHeight)
        }
        
        timeLab.text = "剛剛"
        timeLab.textColor = UUGrayTextColor()
        timeLab.font = UUNormalFontSize(14)
        addSubview(timeLab)
        timeLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(sourceLab)
            make.left.equalTo(sourceLab.snp.right).offset(UUGlobeSpace())
        }
    }
    
    func setUpVideoView(_ data: MMArticle) {
        backgroundColor = .green
    }
    
    func setUpNoImgView(_ data: MMArticle) {
        backgroundColor = .white
        let width = UUWidth() - 2 * UUGlobeSpace()
        
        titleLab.text = data.title
        titleLab.font = UUBoldFontSize(20)
        titleLab.numberOfLines = 0
        let labelSize = titleLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UUGlobeSpace())
            make.left.equalToSuperview().offset(UUGlobeSpace())
            make.size.equalTo(labelSize)
        }
        
        sourceLab.text = "\(data.sourceName ?? "") \(data.commentsCount ?? 0)觀看 \(data.createdAtHuman ?? "")"
        sourceLab.textColor = UUGrayTextColor()
        sourceLab.font = UUNormalFontSize(14)
        sourceLab.textAlignment = .center
        addSubview(sourceLab)
        sourceLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-UUGlobeSpace())
            make.left.equalTo(titleLab)
        }
    }
    
    func setUpOneImgView(_ data: MMArticle) {
        backgroundColor = .white
        let width = UUWidth() - 2 * UUGlobeSpace()

        sourceLab.text = "\(data.sourceName ?? "") \(data.commentsCount ?? 0)觀看 \(data.createdAtHuman ?? "")"
        sourceLab.textColor = UUGrayTextColor()
        sourceLab.font = UUNormalFontSize(14)
        sourceLab.textAlignment = .center
        let size = sourceLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(sourceLab)
        sourceLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-UUGlobeSpace())
            make.left.equalToSuperview().offset(UUGlobeSpace())
            make.size.equalTo(size)
        }

        let model = data.images?[0]
        let picImageView = UIImageView()
        picImageView.layer.cornerRadius = 8.0
        picImageView.clipsToBounds = true
        picImageView.kf.setImage(with: URL.init(string: model?.imageUrl ?? ""))
        let imageHeight = MMHomeSecondTableViewCell.cellHeight(type: .oneImg) - size.height - 3 * UUGlobeSpace()
        let imageWidth = width * 0.4
        addSubview(picImageView)
        picImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UUGlobeSpace())
//            make.bottom.equalTo(sourceLab.snp.top).offset(-UUGlobeSpace())
            make.right.equalToSuperview().offset(-UUGlobeSpace())
            make.size.equalTo(CGSize.init(width: imageWidth, height: imageHeight))
        }

        titleLab.text = data.title
        titleLab.font = UUBoldFontSize(20)
        titleLab.numberOfLines = 0
        let labelSize = titleLab.sizeThatFits(CGSize.init(width: width * 0.6 - UUGlobeSpace(), height: imageHeight))
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UUGlobeSpace())
            make.left.equalTo(sourceLab)
            make.size.equalTo(labelSize)
        }
    }
    
    func setUpThreeImgView(_ data: MMArticle) {
        backgroundColor = .white
        let width = UUWidth() - 2 * UUGlobeSpace()

        titleLab.text = data.title
        titleLab.font = UUBoldFontSize(20)
        titleLab.numberOfLines = 0
        let labelSize = titleLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UUGlobeSpace())
            make.left.equalToSuperview().offset(UUGlobeSpace())
            make.size.equalTo(labelSize)
        }

        sourceLab.text = "\(data.sourceName ?? "") \(data.commentsCount ?? 0)觀看 \(data.createdAtHuman ?? "")"
        sourceLab.textColor = UUGrayTextColor()
        sourceLab.font = UUNormalFontSize(14)
        sourceLab.textAlignment = .center
        let size = sourceLab.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        addSubview(sourceLab)
        sourceLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-UUGlobeSpace())
            make.left.equalTo(titleLab)
            make.size.equalTo(size)
        }

        for i in 0..<(data.images?.count ?? 0) {
            let model = data.images?[i]

            let picImageView = UIImageView()
            picImageView.layer.cornerRadius = 8.0
            picImageView.clipsToBounds = true
            picImageView.kf.setImage(with: URL.init(string: model?.imageUrl ?? ""))
            let spaceCount = (data.images?.count ?? 0) - 1
            let imgWidth = (width - CGFloat(spaceCount) * UUGlobeSpace()) / (data.images?.count ?? 0)
            let imgHeight = MMHomeSecondTableViewCell.cellHeight(type: .threeImg) - labelSize.height - UUGlobeSpace()*4 - size.height
            let leftSpace = CGFloat(i) * (UUGlobeSpace() + imgWidth)
            addSubview(picImageView)
            picImageView.snp.makeConstraints { (make) in
                make.left.equalTo(titleLab).offset(leftSpace)
                make.top.equalTo(titleLab.snp.bottom).offset(UUGlobeSpace())
//                make.bottom.equalTo(sourceLab.snp.top).offset(-UUGlobeSpace())
                make.size.equalTo(CGSize.init(width: imgWidth, height: imgHeight))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
