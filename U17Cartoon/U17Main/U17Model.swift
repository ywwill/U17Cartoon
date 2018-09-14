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



