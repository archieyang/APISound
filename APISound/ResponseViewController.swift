//
//  ResponseViewController.swift
//  APISound
//
//  Created by archie on 15/6/11.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController, UITabBarDelegate {
    enum ResponsePart: Int {
        case Body = 0, Headers
    }
    
    var currentPart: ResponsePart!
    
    var prettyFormatted = true
    
    var response: APIResponse?
    
    var request: APIRequest!
    
    @IBOutlet weak var prettySegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomTabBar: UITabBar!
    
    @IBOutlet weak var responseTextView: UITextView!
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func formatChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            prettyFormatted = true
        case 1:
            prettyFormatted = false
        default:
            prettyFormatted = false
        }
        
        refreshText()
    }


    
    override func viewDidLoad() {
        bottomTabBar.delegate = self
        bottomTabBar.selectedItem = (bottomTabBar.items as! [UITabBarItem])[0]
        currentPart = .Body
        
        responseTextView.textContainerInset = UIEdgeInsetsMake(CGFloat(0),CGFloat(16) , CGFloat(0), CGFloat(16))
    }
    
    override func viewWillAppear(animated: Bool) {
        HttpFetcher().execute(request) { response in
            self.response = response
            self.refreshText()
        }
    }
    
    //MARK: UIBottomBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        currentPart = ResponsePart(rawValue: item.tag)
        println("currentPart = \(currentPart.rawValue)")
        refreshText()
    }
    
    //MARK: Helpers
    
    private func refreshText() -> Void {
        
        switch currentPart! {
        case .Body:
            prettySegmentedControl.hidden = false
            if let responseString = response?.body {
                responseTextView.text = prettyFormatted ? JSONStringify(responseString) : responseString
            } else {
                responseTextView.text = "No Response"
            }
            
        case .Headers:
            prettySegmentedControl.hidden = true
            responseTextView.text = response?.getFormattedHeader() ?? "No Response"
        }
    }
    
    private func JSONStringify(jsonString: String) -> String {

        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) {
                if let formattedData = NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions.PrettyPrinted, error: nil) {
                    return NSString(data:formattedData, encoding: NSUTF8StringEncoding) as! String
                }
            }
        }
        
        return "Pretty Format Not Supported"
    }

}
