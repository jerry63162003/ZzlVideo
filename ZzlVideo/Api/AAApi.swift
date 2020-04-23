//
//  AAApi.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/21/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class Error: NSObject,Mappable {
    var message : String?
    var errorId : NSInteger?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        message <- map["Message"]
        errorId <- map["error_id"]
        errorId <- map["Error"]
    }
}

class Paginate: NSObject, Mappable {
    var currentPage : NSInteger?
    var firstPageUrl : String?
    var from : NSInteger?
    var lastPage : NSInteger?
    var lastPageUrl : String?
    var nextPageUrl : String?
    var path : String?
    var perPage : NSInteger?
    var prevPageUrl : String?
    var to : NSInteger?
    var total : NSInteger?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        currentPage <- map["current_page"]
        firstPageUrl <- map["first_page_url"]
        from <- map["from"]
        lastPage <- map["last_page"]
        lastPageUrl <- map["last_page_url"]
        nextPageUrl <- map["next_page_url"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageUrl <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
    }
}

class Response: NSObject,Mappable {
    var error:Error?
    var paginate:Paginate?
    var result : Any!

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        error <- map["error"]
        error <- map["Error"]
        result <- map["result"]
        result <- map["Result"]
        
        result <- map["data"]
        paginate <- map["paginate"]
    }
}

func baseUrl() -> String {
    return "https://api.180086.com"
}

class AAApi {
    
    static let shared = AAApi()
    
    init(){}
    
    typealias blockResponse = (_ res : Response)->Void
    typealias blockArrayRes = (_ res : Array<Dictionary<String, Any>>)->Void
    typealias blockError = (_ res : String)->Void
    typealias blockTokenError = ()->Void
    
    private var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return SessionManager(configuration: configuration)
    }()
    
    private var header: HTTPHeaders = {
        var header = HTTPHeaders()
        var dic:Dictionary<String, String> = [:]
        dic["Content-Type"] = "application/json;charset=UTF-8"
        header = dic
        return header
    }()
    
    // MARK: - API base
    private func GET(url:String, sender:Parameters?, onHandleSuccess:@escaping blockResponse, onHandleError:@escaping blockError) {
        
        manager.request(baseUrl() + url, method: .get, parameters: sender, encoding: URLEncoding.default, headers: header).responseJSON {(response) in
            switch response.result {
            case .success(let value):
                
                let statusCode = response.response?.statusCode
                if let res = Response(JSON: value as! [String:Any]){
                    if statusCode == 200 {
                        onHandleSuccess(res)
                        return
                    }
                    onHandleError(res.error?.message ?? "")
                }
            case .failure(let error):
                if let error = error as? URLError {
                    switch error.code.rawValue {
                    case NSURLErrorTimedOut:
                        onHandleError("请求超时")
                        break
                    default:
                        onHandleError("请检查您的网路状况")
                        break
                    }
                }
            }
        }
    }
    
    private func GETArray(url:String, sender:Parameters?, onHandleSuccess:@escaping blockArrayRes, onHandleError:@escaping blockError) {
        
        manager.request(baseUrl() + url, method: .get, parameters: sender, encoding: URLEncoding.default, headers: header).responseJSON {(response) in
            switch response.result {
            case .success(let value):
                let statusCode = response.response?.statusCode
                if let res:Array<Dictionary<String, Any>> = value as? Array<Dictionary<String, Any>> {
                    if statusCode == 200 {
                        onHandleSuccess(res)
                    }
                    return
                }
                
            case .failure(let error):
                if let error = error as? URLError {
                    switch error.code.rawValue {
                    case NSURLErrorTimedOut:
                        onHandleError("请求超时")
                        break
                    default:
                        onHandleError("请检查您的网路状况")
                        break
                    }
                }
            }
        }
    }
    
    private func POST(url:String, sender:[String:Any], onHandleSuccess:@escaping blockResponse, onHandleError:@escaping blockError, onTokenError:@escaping blockTokenError){
        
        manager.request(baseUrl() + url, method: .post, parameters: sender, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print("post url:\(String(describing: response.request?.url?.absoluteString))")
            switch response.result {
            case .success(let value):
                let statusCode = response.response?.statusCode
                if let res = Response(JSON: value as! [String:Any]){
                    if statusCode == 200{
                        onHandleSuccess(res)
                        return
                    }
                    if statusCode == 401{
                        onTokenError()
                        return
                    }
                    onHandleError(res.error?.message ?? "")
                }
            case .failure(let error):
                if let error = error as? URLError {
                    switch error.code.rawValue {
                    case NSURLErrorTimedOut:
                        onHandleError("请求超时")
                        break
                    default:
                        onHandleError("请检查您的网路状况")
                        break
                    }
                }
            }
        }
    }
    
    //GET
    public func articleType(onHandleSuccess:@escaping blockArrayRes, onHandleError:@escaping blockError) {
         GETArray(url: "/api/v2/article/type", sender: [:], onHandleSuccess: onHandleSuccess,onHandleError: onHandleError)
    }
    
    public func article(sender:[String:String], onHandleSuccess:@escaping blockResponse, onHandleError:@escaping blockError) {
        GET(url: "/api/v2/article", sender: sender, onHandleSuccess: onHandleSuccess,onHandleError: onHandleError)
    }
    
    public func taskList(onHandleSuccess:@escaping blockResponse, onHandleError:@escaping blockError) {
         GET(url: "/api/v1/task/list", sender: [:], onHandleSuccess: onHandleSuccess,onHandleError: onHandleError)
    }
    
    //POST
}
