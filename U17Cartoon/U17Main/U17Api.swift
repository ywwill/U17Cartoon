//
//  Api.swift
//  SwiftProject
//
//  Created by YangWei on 2018/9/14.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SVProgressHUD

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

// 打印请求日志
private func reversedPrint(_ separator: String, terminator: String, items: Any...) {
    for item in items {
        print(item, separator: separator, terminator: terminator)
    }
}

// loading plugin
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        SVProgressHUD.show()
    case .ended:
        SVProgressHUD.dismiss()
    }
}

// log plugin
let LoggerPlugin = NetworkLoggerPlugin(verbose: true, output:reversedPrint, responseDataFormatter: { (data: Data) -> Data in
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)// Data 转 JSON
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)// JSON 转 Data，格式化输出。
        return prettyData
    } catch {
        return data
    }
})

// 设置超时时常
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<UApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}


let ApiProvider = MoyaProvider<UApi>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<UApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin, LoggerPlugin])

enum UApi {
    case searchHot//搜索热门
    case searchRelative(inputText: String)//相关搜索
    case searchResult(argCon: Int, q: String)//搜索结果
    
    case favList //收藏列表
    case todayList//今日列表
    case historyList // 阅读历史列表
    case boutiqueList(sexType: Int)//推荐列表
    case special(argCon: Int, page: Int)//专题
    case vipList//VIP列表
    case subscribeList//订阅列表
    case rankList//排行列表
    
    case cateList//分类列表
    
    case comicList(argCon: Int, argName: String, argValue: Int, page: Int)//漫画列表
    
    case guessLike//猜你喜欢
    
    case detailStatic(comicid: Int)//详情(基本)
    case detailRealtime(comicid: Int)//详情(实时)
    case commentList(object_id: Int, thread_id: Int, page: Int)//评论
    
    case chapter(chapter_id: Int)//章节内容
}

extension UApi: TargetType {
    
    var baseURL: URL { return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")! }
    
    var path: String {
        switch self {
        case .searchHot: return "search/hotkeywordsnew"
        case .searchRelative: return "search/relative"
        case .searchResult: return "search/searchResult"
        
        case .favList: return "fav/index"
        case .todayList: return "comic/todayRecommend"
        case .historyList: return "read/readhistory"
        case .boutiqueList: return "comic/boutiqueListNew"
        case .special: return "comic/special"
        case .vipList: return "list/vipList"
        case .subscribeList: return "list/newSubscribeList"
        case .rankList: return "rank/list"
            
        case .cateList: return "sort/mobileCateList"
            
        case .comicList: return "list/commonComicList"
            
        case .guessLike: return "comic/guessLike"
            
        case .detailStatic: return "comic/detail_static_new"
        case .detailRealtime: return "comic/detail_realtime"
        case .commentList: return "comment/list"
            
        case .chapter: return "comic/chapterNew"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters = ["time": Int32(Date().timeIntervalSince1970),
                         "device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "model": "none",
                         "target": "U17_3.0",
                         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        switch self {
        case .searchRelative(let inputText):
            parmeters["inputText"] = inputText
            
        case .searchResult(let argCon, let q):
            parmeters["argCon"] = argCon
            parmeters["q"] = q
        
        case .boutiqueList(let sexType):
            parmeters["sexType"] = sexType
            parmeters["v"] = 3320101
            
        case .special(let argCon,let page):
            parmeters["argCon"] = argCon
            parmeters["page"] = max(1, page)
            
        case .cateList:
            parmeters["v"] = 2
            
        case .comicList(let argCon, let argName, let argValue, let page):
            parmeters["argCon"] = argCon
            if argName.count > 0 { parmeters["argName"] = argName }
            parmeters["argValue"] = argValue
            parmeters["page"] = max(1, page)
            
        case .detailStatic(let comicid),
             .detailRealtime(let comicid):
            parmeters["comicid"] = comicid
            parmeters["v"] = 3320101
            
        case .commentList(let object_id, let thread_id, let page):
            parmeters["object_id"] = object_id
            parmeters["thread_id"] = thread_id
            parmeters["page"] = page
            
        case .chapter(let chapter_id):
            parmeters["chapter_id"] = chapter_id
            
        default: break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    //设置请求头header
    var headers: [String : String]? { return nil }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData?.data?.returnData)
        })
    }
}


