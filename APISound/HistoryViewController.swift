//
//  HistoryViewController.swift
//  APISound
//
//  Created by archie on 15/6/14.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var requestList = [APIRequest]()
    
    var mainViewController: MainViewController {
        return (self.slideMenuController()?.mainViewController as! UINavigationController).topViewController as! MainViewController
    }

    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        APIRequestManager.sharedInstance.fetchAll { apiRequests in
            self.requestList = apiRequests
            self.historyTableView.reloadData()
            
            for request in self.requestList {
                for param in request.urlParamList{
                    println(param.key + " -> " + param.value)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Data Source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyViewCell", forIndexPath: indexPath) as! HistoryViewCell
        cell.urlLabel.text = requestList[indexPath.row].url
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestList.count
    }
    
    //MARK: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.mainViewController.apiRequest = requestList[indexPath.row]
        self.slideMenuController()?.closeLeft()
    }

}
