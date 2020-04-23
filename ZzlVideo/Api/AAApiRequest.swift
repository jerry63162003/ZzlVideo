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
            UUStopShowLoadingHud()
        }
    }
    
    func article(sender: Dictionary<String, String>, callBack:@escaping (Array<MMArticle>) -> Void) {
        UUShowLoadingHud(message: "加載中")
        AAApi.shared.article(sender: sender, onHandleSuccess: { (response) in
            UUStopShowLoadingHud()
            var arr = Array<MMArticle>()
            for model in response.result as! Array<Any> {
                arr.append(MMArticle(JSON: model as! [String:Any])!)
            }
            callBack(arr)
        }) { (error) in
            UUStopShowLoadingHud()
        }
    }
    
    func taskList(callBack:@escaping (Array<MMTaskList>) -> Void) {
        UUShowLoadingHud(message: "加載中")
        AAApi.shared.taskList(onHandleSuccess: { (response) in
            UUStopShowLoadingHud()
            var arr = Array<MMTaskList>()
            for model in response.result as! Array<Any> {
                arr.append(MMTaskList(JSON: model as! [String:Any])!)
            }
            callBack(arr)
        }) { (error) in
            UUStopShowLoadingHud()
        }
    }
}
