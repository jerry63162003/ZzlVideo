//
//  MMTaskList.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/23/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import ObjectMapper
//"id": 11,
//"title": "点击链接加入群聊【转转乐任务群】859785620",
//"content": "<p>点击链接加入群聊【转转乐任务群】：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=5WQslk8\" target=\"_blank\" rel=\"noopener\">https://jq.qq.com/?_wv=1027&amp;k=5WQslk8</a><br />添加转转乐任务群:859785620</p>\n<p>&nbsp;</p>",
//"copy_content": null,
//"money": "0.50",
//"state": 1,
//"state_text": "进行中",
//"created_at": "2020-03-13 00:19:19",
//"updated_at": "2020-03-20 17:08:48"

class MMTaskList: NSObject, Mappable {
    var id : NSInteger?
    var title : String?
    var content : String?
    var copyContent : String?
    var money : String?
    var state : NSInteger?
    var stateText : String?
    var createdAt : String?
    var updatedAt : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        copyContent <- map["copy_content"]
        money <- map["money"]
        state <- map["state"]
        stateText <- map["state_text"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}
