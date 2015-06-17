//
//  HistoryViewController.swift
//  APISound
//
//  Created by archie on 15/6/14.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var requestList = [APIRequest]()

    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        historyTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        APIRequest.fetchAll { apiRequests in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Table View Data Source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyViewCell", forIndexPath: indexPath) as! HistoryViewCell
        cell.urlLabel.text = requestList[indexPath.row].url
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestList.count
    }

}
