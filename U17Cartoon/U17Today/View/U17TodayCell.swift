//
//  U17TodayCell.swift
//  U17Cartoon
//
//  Created by YangWei on 2018/9/14.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import UIKit
import Kingfisher

class U17TodayCell: UITableViewCell {
    
    lazy var picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20.0
        return imageView
    }()
    
    lazy var redBtn: UIButton = {
       let button = UIButton(type: UIButtonType.custom)
        button.setTitle("阅读漫画", for: UIControlState.normal)
        button.backgroundColor = buttonBackColor
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        self.addSubview(self.picImageView)
        
        self.picImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
        self.picImageView.addSubview(self.redBtn)
        self.redBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(30)
        }
    }
    
    var dayItemModel: DayItemModel? {
        didSet {
            guard let model = dayItemModel else { return }
            self.picImageView.kf.setImage(with: URL(string: model.cover!))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
