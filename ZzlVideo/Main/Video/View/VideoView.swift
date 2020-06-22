//
//  VideoView.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/27/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//


import UIKit
import AVFoundation
import SJVideoPlayer

class SjVideoView: UIView {
    
    let videoCoverView = VideoCoverView()
    
    let sjPlayer = SJVideoPlayer()
    var isPlaying:Bool = false
    typealias videoPlayBlock = (_ isPlaying: Bool) -> Void
    var videoPlayClick : videoPlayBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConfigView()
    }
    
    func setUpConfigView() {
        addSubview(videoCoverView)
        videoCoverView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        videoCoverView.playBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
    }
    
    func setUpVideoView(data: MMArticle, tableView: UITableView, indexPath: IndexPath) {
        /*
         * title 標題
         * video_preview 預置圖片
         * video 影片url
         * comments_count 播放次數
         * duration 影片長度
         * source_name 來源名
         * created_at_human 時間
         */
        sjPlayer.presentView.placeholderImageView.kf.setImage(with: URL.init(string: data.videoPreview ?? ""))
        
        //cell中的播放器暂停后,滑动不让cell里的播放器自动播放
        sjPlayer.resumePlaybackWhenScrollAppeared = false
        //禁止自動旋轉
        sjPlayer.rotationManager.isDisabledAutorotation = true
        //播放器准备好显示时, 是否隐藏占位图
//        sjPlayer.hiddenPlaceholderImageViewWhenPlayerIsReadyForDisplay = false
        
        if let url = URL.init(string: data.video ?? "") {
            let asset = SJVideoPlayerURLAsset.init(url: url, playModel: SJPlayModel.uiTableViewCellPlayModel(withPlayerSuperviewTag: tag, at: indexPath, tableView: tableView))
            asset?.title = data.title ?? ""
            sjPlayer.urlAsset = asset
        }
        
        sjPlayer.view.frame = videoCoverView.bounds
        addSubview(sjPlayer.view)
        
    }
    
    @objc func playVideo() {
        isPlaying = !isPlaying
        videoCoverView.isHidden = isPlaying ? true:false
        if videoPlayClick != nil {
            videoPlayClick!(isPlaying)
        }
    }

    func setVideoPlayClickBlock(block:@escaping videoPlayBlock) -> Void {
        videoPlayClick = block
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoView: UIView {
    //view
    let videoCoverView = VideoCoverView()
    var isPlaying:Bool = false
    //tool
    let toolView = UIView()
    var startLab = UILabel()
    var endLab = UILabel()
    var progressView = UISlider()
    var pullScreenBtn = UIButton()
    var timeInterval : NSInteger = 3
    var timer : Timer?
    
    typealias videoPlayBlock = (_ index:NSInteger, _ view: UIView, _ isPlaying: Bool) -> Void
    var videoPlayClick : videoPlayBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUpConfigView() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(playVideo))
        tap.numberOfTapsRequired = 1
        videoCoverView.isUserInteractionEnabled = true
        videoCoverView.addGestureRecognizer(tap)
        addSubview(videoCoverView)
        videoCoverView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        videoCoverView.playBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
    }
    
    func setUpToolView(data: MMArticle) {
        let toolViewHeight = UUCalculateSize(40)
        toolView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.30)
        addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(videoCoverView)
            make.height.equalTo(toolViewHeight)
            make.width.equalTo(UUWidth())
        }
        
        pullScreenBtn.setImage(UIImage(named: "ic_video_exit_full"), for: .normal)
        toolView.addSubview(pullScreenBtn)
        pullScreenBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-UUGlobeSpace()/2)
            make.width.height.equalTo(toolViewHeight * 0.5)
        }
        
        startLab = labelInit("00:00")
        let startSize = startLab.sizeThatFits(CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)))
        toolView.addSubview(startLab)
        startLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(UUGlobeSpace()/2)
            make.size.equalTo(startSize)
        }
        
        endLab = labelInit(data.duration ?? "")
        let endSize = startLab.sizeThatFits(CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)))
        toolView.addSubview(endLab)
        endLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(pullScreenBtn.snp.left).offset(-UUGlobeSpace()/2)
            make.size.equalTo(endSize)
        }
        
        progressView.minimumValue = 0
        progressView.maximumValue = 10
        progressView.maximumTrackTintColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        progressView.minimumTrackTintColor = UIColor(red: 0.00, green: 0.75, blue: 0.43, alpha: 1.00)
        progressView.setThumbImage(UIImage(named: "ic_video_tool_slider"), for: .normal)
        toolView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(startLab.snp.right).offset(UUGlobeSpace()/2)
            make.right.equalTo(endLab.snp.left).offset(-UUGlobeSpace()/2)
        }
    }
    
    @objc func playVideo() {
        if videoPlayClick != nil {
            isPlaying = !isPlaying
            videoCoverView.bgImageView.isHidden = true
            videoCoverView.playTimeLab.isHidden = true
            videoCoverView.durationLab.isHidden = true
            videoPlayClick!(self.tag, videoCoverView, isPlaying)
        }
    }
    
    func setVideoPlayClickBlock(block:@escaping videoPlayBlock) -> Void {
        videoPlayClick = block
    }
    
    func setTimer() {
        videoCoverView.playBtn.setImage(UIImage(named:isPlaying ? "ic_video_pause": "ic_video_play"), for: .normal)
        videoCoverView.playBtn.isHidden = false
        videoCoverView.titleLab.isHidden = false
        toolView.isHidden = false
        videoCoverView.playTimeLab.isHidden = true
        videoCoverView.durationLab.isHidden = true
        timeInterval = 3
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeAction(sender:)), userInfo: nil, repeats: true)
    }
    
    func hideToolView() {
        toolView.isHidden = true
        timer!.invalidate()
    }
    
    @objc func timeAction(sender:Timer){
        if isPlaying {
            videoCoverView.playBtn.isHidden = true
            videoCoverView.titleLab.isHidden = true
        } else {
            videoCoverView.playBtn.isHidden = false
            videoCoverView.playTimeLab.isHidden = false
            videoCoverView.durationLab.isHidden = false
        }
        hideToolView()
    }
    
    func pauseShowView() {
        isPlaying = false
        videoCoverView.bgImageView.isHidden = false
        videoCoverView.playBtn.isHidden = false
        videoCoverView.titleLab.isHidden = false
        videoCoverView.playTimeLab.isHidden = false
        videoCoverView.durationLab.isHidden = false
        videoCoverView.playBtn.setImage(UIImage(named:"ic_video_play"), for: .normal)
    }
    
    func labelInit(_ text: String) -> UILabel {
        let lab = UILabel()
        lab.text = text
        lab.textColor = .white
        lab.font = UUNormalFontSize(14)
        lab.textAlignment = .center
        addSubview(lab)
        return lab
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCoverView: UIView {
    let videoView = UIView()
    let bgImageView = UIImageView()
    var titleLab = UILabel()
    let playBtn = UIButton()
    var playTimeLab = UILabel()
    var durationLab = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUpConfigView(data: MMArticle) {
        /*
         * title 標題
         * video_preview 預置圖片
         * video 影片url
         * comments_count 播放次數
         * duration 影片長度
         * source_name 來源名
         * created_at_human 時間
         */
        addSubview(videoView)
        videoView.snp.makeConstraints { (make) in
            make.top.left.right.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: UUWidth(), height: UUWidth() * 9 / 16))
        }
        
        bgImageView.kf.setImage(with: URL.init(string: data.videoPreview ?? ""))
        videoView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        titleLab = labelInit(" \(data.title ?? "")")
        titleLab.textAlignment = .left
        titleLab.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.30)
        titleLab.adjustsFontSizeToFitWidth = true
        titleLab.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UUCalculateSize(40))
            make.width.equalTo(UUWidth())
        }
        
//        playBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        playBtn.setImage(UIImage(named: "ic_video_play"), for: .normal)
        addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        playTimeLab = labelInit("\(data.commentsCount ?? 0)次播放")
        playTimeLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(UUGlobeSpace())
            make.bottom.equalToSuperview().offset(-UUGlobeSpace())
        }
        
        durationLab = labelInit(data.duration ?? "")
        let durationLabSize = durationLab.sizeThatFits(CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)))
        durationLab.layer.cornerRadius = (durationLabSize.height + UUGlobeSpace()) / 2
        durationLab.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.50)
        durationLab.clipsToBounds = true
        durationLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-UUGlobeSpace())
            make.centerY.equalTo(playTimeLab)
            make.size.equalTo(CGSize.init(width: durationLabSize.width + 2*UUGlobeSpace(), height: durationLabSize.height + UUGlobeSpace()))
        }
    }
    
    func labelInit(_ text: String) -> UILabel {
        let lab = UILabel()
        lab.text = text
        lab.textColor = .white
        lab.font = UUNormalFontSize(14)
        lab.textAlignment = .center
        addSubview(lab)
        return lab
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
