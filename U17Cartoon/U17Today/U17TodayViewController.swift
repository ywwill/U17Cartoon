//
//  U17TodayViewController.swift
//  U17Cartoon
//
//  Created by YangWei on 2018/9/14.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import UIKit
import SnapKit

class U17TodayViewController: UIViewController {
    
    private let CellIndentifier = "U17TodayCell"
    private let FooterIndentifier = "U17TodayFooterView"
    private let HeaderIndentifier = "U17TodayHeaderView"
    
    private var dayDataList = [DayItemDataListModel]()
    
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect(x:0, y:20, width:KScreenWidth, height: KScreenHeight-20), style: UITableViewStyle.grouped)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.backgroundColor = ThemeColor
        tabView.register(U17TodayCell.self, forCellReuseIdentifier: CellIndentifier)
        tabView.register(U17TodayFooterView.self, forHeaderFooterViewReuseIdentifier: FooterIndentifier)
        tabView.register(U17TodayHeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderIndentifier)
        tabView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        return tabView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ThemeColor
        
        self.view.addSubview(self.tableView)
        
        loadData()
    }
    
    func loadData() {
        ApiLoadingProvider.request(UApi.todayList, model: DayDataModel.self) { [weak self] (returnData) in
            self?.dayDataList = returnData?.dayDataList ?? []
            
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension U17TodayViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dayDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dayDataList[section].dayItemDataList?.count)!-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: U17TodayCell = tableView.dequeueReusableCell(withIdentifier: CellIndentifier, for: indexPath) as! U17TodayCell
        cell.backgroundColor = ThemeColor
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.dayItemModel = self.dayDataList[indexPath.section].dayItemDataList?[indexPath.row]
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: U17TodayHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderIndentifier) as! U17TodayHeaderView
        headerView.dayDataModel = self.dayDataList[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView: U17TodayFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterIndentifier) as! U17TodayFooterView
        let dayItem: DayItemModel = (self.dayDataList[section].dayItemDataList?.last)!
        footerView.dayItemModel = dayItem
        footerView.delegate =  self as U17TodayFooterViewDelegate
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = self.dayDataList[indexPath.section].dayItemDataList?[indexPath.row]
        print("selected")
    }
}

extension U17TodayViewController: U17TodayFooterViewDelegate {
    func readCartoon(dayComicItemModel: dayComicItemModel?) {
       print("selected")
    }
}
