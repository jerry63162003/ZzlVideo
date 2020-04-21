//
//  AAApiRequest.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/21/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

class AAApiRequest: NSObject {
    
    func articleType(callBack:@escaping (Array<MMArticleType>) ->Void) {
        AAApi.shared.articleType(onHandleSuccess: { (response) in
            var arr = Array<MMArticleType>()
            for model in response {
                arr.append(MMArticleType(JSON: model)!)
            }
            callBack(arr)
        }) { (error) in
            
        }
    }
    
    func article(sender: Dictionary<String, String>, callBack:@escaping (Array<MMArticle>) -> Void) {
        AAApi.shared.article(sender: sender, onHandleSuccess: { (response) in
            
            var arr = Array<MMArticle>()
            for model in response.result as! Array<Any> {
                arr.append(MMArticle(JSON: model as! [String:Any])!)
            }
            callBack(arr)
        }) { (error) in
            
        }
    }
}
