//
//  MMArticleType.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/21/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//
import ObjectMapper
//"id": 300,
//"value": "recommend",
//"text": "推荐",
//"money": "0.05"

class MMArticleType: NSObject, Mappable {
    var id : NSInteger?
    var value : String?
    var text : String?
    var money : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        value <- map["value"]
        text <- map["text"]
        money <- map["money"]
    }
}
