//
//  U17TodayHeaderView.swift
//  U17Cartoon
//
//  Created by YangWei on 2018/9/14.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import UIKit

class U17TodayHeaderView: UITableViewHeaderFooterView {
    
    //星期
    lazy var week_lb: UILabel = {
       let lable = UILabel()
        lable.text = "星期六"
        lable.textColor = UIColor.black
        lable.font = UIFont.systemFont(ofSize: 30)
        return lable
    }()
    
    //时间
    lazy var time_lb: UILabel = {
        let lable = UILabel()
        lable.text = "09月14日"
        lable.textColor = UIColor.gray
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.time_lb)
        self.time_lb.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(30)
            make.height.equalTo(30)
            make.right.equalToSuperview()
        }
        
        self.addSubview(self.week_lb)
        self.week_lb.snp.makeConstraints { (make) in
            make.left.equalTo(self.time_lb.snp.left)
            make.top.equalTo(self.time_lb.snp.bottom)
            make.height.equalTo(45)
            make.right.equalTo(self.time_lb.snp.right)
        }
    }
    
    var dayDataModel: DayItemDataListModel? {
        didSet {
            guard let model = dayDataModel else { return }
            
            self.week_lb.text = model.weekDay
            
            let time = (model.timeStamp! as NSString).intValue
            let date = NSDate(timeIntervalSince1970: TimeInterval(time))
            let timeStr = dateConvertString(date: date as Date)
            self.time_lb.text = timeStr
        }
    }
    
    //时间戳转时间格式
    func dateConvertString(date: Date, dateFormat: String = "yyyy-mm-dd") -> String {
        let timeZone = TimeZone(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
