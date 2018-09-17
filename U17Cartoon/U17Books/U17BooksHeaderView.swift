//
//  U17BooksHeaderView.swift
//  U17Cartoon
//
//  Created by YangWei on 2018/9/17.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import UIKit

class U17BooksHeaderView: UIView {
    lazy var coverImageView = UIImageView() // book封面
    lazy var titleLabel = UILabel() // 标题
    lazy var authorLabel = UILabel() // 
    lazy var clickAndCollectLabel = UILabel() // 点击量
    lazy var bgView = UIView() // 背景图
    lazy var classifyView = UIView() // tags分类
    lazy var blurImageView = UIImageView() // 毛玻璃效果
    
    private var items:[String] = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        self.addSubview(self.bgView)
        self.blurImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: self.frame.height))
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = self.blurImageView.bounds
        self.blurImageView.addSubview(visualEffectView)
        
        self.insertSubview(self.blurImageView, belowSubview: self.bgView)
        
        self.bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self)
            make.center.equalTo(self)
        }
        
        self.addSubview(self.coverImageView)
        self.coverImageView.layer.masksToBounds = true
        self.coverImageView.layer.cornerRadius = 5
        self.coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(64+10)
            make.bottom.equalTo(-20)
            make.width.equalTo(120)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.coverImageView.snp.top)
            make.left.equalTo(self.coverImageView.snp.right).offset(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.authorLabel)
        self.authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
            make.height.equalTo(self.titleLabel.snp.height)
        }
        
        self.addSubview(self.clickAndCollectLabel)
        self.clickAndCollectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.authorLabel.snp.bottom).offset(15)
            make.left.equalTo(self.authorLabel.snp.left)
            make.right.equalTo(self.authorLabel.snp.right)
            make.height.equalTo(self.authorLabel.snp.height)
        }
        
        self.addSubview(self.classifyView)
        self.classifyView.snp.makeConstraints { (make) in
            make.left.equalTo(self.clickAndCollectLabel.snp.left)
            make.right.equalTo(self.clickAndCollectLabel.snp.right)
            make.height.equalTo(30)
            make.bottom.equalTo(self.coverImageView.snp.bottom).offset(-10)
        }
    }
    
    var detailStatic: ComicStaticModel? {
        didSet {
            guard let detailStatic = detailStatic else { return }
            self.blurImageView.kf.setImage(with: URL(string: detailStatic.cover!))
            self.coverImageView.kf.setImage(with: URL(string:detailStatic.cover!))
            self.titleLabel.text = detailStatic.name
            self.authorLabel.text = detailStatic.author?.name
            
            // 分类
            let margin:CGFloat = 40
            items.removeAll()
            items = detailStatic.theme_ids!
            
            for view in self.classifyView.subviews {
                view.removeFromSuperview()
            }
            
            for index in 0..<items.count {
                let label = UILabel.init(frame: CGRect(x:margin*CGFloat(index)+15*CGFloat(index),y:2.5,width:margin,height:25))
                label.text = nil
                label.textAlignment = .center
                label.textColor = UIColor.white
                label.layer.borderColor = UIColor.white.cgColor
                label.layer.borderWidth = 1
                label.layer.masksToBounds = true
                label.layer.cornerRadius = 2
                label.text = items[index]
                label.font = UIFont.systemFont(ofSize: 15)
                self.classifyView.addSubview(label)
            }
        }
    }
    
    var detailRealtime: ComicRealtimeModel? {
        didSet {
            guard let detailRealtime = detailRealtime else { return }
            let text = NSMutableAttributedString(string: "点击 收藏")
            
            text.insert(NSAttributedString(string: "\(detailRealtime.click_total ?? "0")",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange,
                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]), at: 2)
            text.append(NSAttributedString(string: " \(detailRealtime.favorite_total ?? "0")",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange,
                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]))
            self.clickAndCollectLabel.attributedText = text
        }
    }
}
