//
//  U17Model.swift
//  U17Cartoon
//
//  Created by YangWei on 2018/9/14.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import Foundation
import HandyJSON

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}

 // MARK: - 今日数据
struct DayDataModel : HandyJSON {
    var dayDataList : [DayItemDataListModel]?
}

struct DayItemDataListModel : HandyJSON {
    var dayItemDataList : [DayItemModel]?
    var weekDay: String?
    var timeStamp: String?
}

struct DayItemModel : HandyJSON {
    var htmlId:Int = 0
    var comicListTitle : String?
    var btnColor: Int = 0
    var cover : String?
    var dataType: Int = 0
    var shortDescription :String?
    var longDescription : String?
    var threadId: Int = 0
    var type: Int = 0
    var isComicCanRead: Bool = false
    var comicId: Int = 0
    var comicName: String?
    var tags: [Any]?
    var comicCover: String?
    var dayComicItemList:[dayComicItemModel]?//小编推荐
}

struct dayComicItemModel: HandyJSON {
    var name : String?
    var comicId: Int = 0
    var cover : String?
    var tags :[Any]?
    var chapterCount: Int = 0
}

// 书籍详情
struct ComicStaticModel: HandyJSON {
    var name: String?
    var comic_id: Int = 0
    var short_description: String?
    var accredit: Int = 0
    var cover: String?
    var is_vip: Int = 0
    var type: Int = 0
    var ori: String?
    var theme_ids: [String]?
    var series_status: Int = 0
    var last_update_time: TimeInterval = 0
    var description: String?
    var cate_id: String?
    var status: Int = 0
    var thread_id: Int = 0
    var last_update_week: String?
    var wideCover: String?
    var classifyTags: [ClassifyTagModel]?
    var is_week: Bool = false
    var comic_color: String?
    var author: AuthorModel?
    var is_dub: Bool = false
}

// 作者
struct AuthorModel: HandyJSON {
    var id: Int = 0
    var avatar: String?
    var name: String?
}

// 书籍分类
struct ClassifyTagModel: HandyJSON {
    var name: String?
    var argName: String?
    var argVal: Int = 0
}

// 书籍点击收藏
struct ComicRealtimeModel: HandyJSON {
    var comic_id: Int = 0
    var user_id: Int = 0
    var status: Int = 0
    var click_total: String?
    var total_ticket: String?
    var comment_total: String?
    var total_tucao: String?
    var favorite_total: String?
    var gift_total: String?
    var monthly_ticket: String?
    var vip_discount: Double = 0
    var is_vip_free: Bool = false
    var is_free: Bool = false
    var is_vip_buy: Bool = false
    var is_auto_buy: Bool = false
}

