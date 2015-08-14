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
    var historyPresenter = HistoryPresenter()
    var historyGroups = [HistorySectionItem]() {
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
    
    override func viewDidLoad() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        historyPresenter.attachUi(self)
    }
    
    //MARK: Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return historyGroups.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = historyGroups[section].mDate
        
        return date
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyViewCell", forIndexPath: indexPath) as! HistoryViewCell
        cell.urlLabel.text = requestList[indexPath.row].url
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyGroups[section].mSize
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
        historyGroups = groups
    }
    
    func setUiCallbacks(callbacks: BaseUiCallbacks) -> Void {
        
    }

}
