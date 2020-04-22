//
//  MMArticle.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/21/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//
import ObjectMapper

class MMArticle: NSObject, Mappable {
    var id : String?
    var title : String?
    var video : String?
    var videoPreview : String?
    var videoResolution : String?
    var duration : String?
    var type : NSInteger?
    var sourceName : String?
    var money : String?
    var viewType : NSInteger?
    var pv : NSInteger?
    var top : NSInteger?
    var pvMax : NSInteger?
    var createdAt : String?
    var createdAtHuman : String?
    var commentsCount : NSInteger?
    var domain : String?
    var picUrl : String?
    var shareUrl : String?
    var videoUrl : String?
    var images : Array<MMArticleImages>?
    var adUrl: String?
    var adStyle: NSInteger?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        video <- map["text"]
        videoPreview <- map["video_preview"]
        videoResolution <- map["video_resolution"]
        duration <- map["duration"]
        type <- map["type"]
        sourceName <- map["source_name"]
        money <- map["money"]
        viewType <- map["view_type"]
        pv <- map["pv"]
        top <- map["top"]
        pvMax <- map["pv_max"]
        createdAt <- map["created_at"]
        createdAtHuman <- map["created_at_human"]
        commentsCount <- map["comments_count"]
        domain <- map["domain"]
        picUrl <- map["pic_url"]
        shareUrl <- map["share_url"]
        videoUrl <- map["video_url"]
        images <- map["images"]
        
        adUrl <- map["ad_url"]
        adStyle <- map["ad_style"]
    }
}

class MMArticleImages: NSObject, Mappable {
    var id : NSInteger?
    var articleId : String?
    var image : String?
    var imageUrl : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        articleId <- map["article_id"]
        image <- map["image"]
        imageUrl <- map["image_url"]
    }
}
