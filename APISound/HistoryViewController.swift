//
//  HistoryViewController.swift
//  APISound
//
//  Created by archie on 15/6/14.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, HistoryUi, UITableViewDataSource, UITableViewDelegate {
    var mHistoryPresenter = HistoryPresenter()
    var mHistoryGroups = [HistorySectionItem]() {
        didSet {
            self.historyTableView.reloadData()
        }
    }
    
    var requestList = [APIRequest]() {
        didSet {
            self.historyTableView.reloadData()
        }
    }
    
    var mainViewController: MainViewController {
        return (self.slideMenuController()?.mainViewController as! UINavigationController).topViewController as! MainViewController
    }

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var noDataHintLabel: UILabel!
    
    override func viewDidLoad() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        mHistoryPresenter.attachUi(self)
    }
    
    //MARK: Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if requestList.count == 0 {
            noDataHintLabel.hidden = false
        } else {
            noDataHintLabel.hidden = true
        }
        
        return mHistoryGroups.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = mHistoryGroups[section].mDate
        
        return date
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyViewCell", forIndexPath: indexPath) as! HistoryViewCell
        cell.urlLabel.text = requestList[indexPath.row].mUrl
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mHistoryGroups[section].mSize
    }
    
    //MARK: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.mainViewController.apiRequest = requestList[indexPath.row]
        self.slideMenuController()?.closeLeft()
    }
    
    func setItems(items: [APIRequest]) {
        requestList = items
    }
    
    func setGroups(groups: [HistorySectionItem]) -> Void {
        mHistoryGroups = groups
    }
    
    func setUiCallbacks(callbacks: BaseUiCallbacks) -> Void {
        
    }

}
