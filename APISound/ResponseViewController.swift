//
//  ResponseViewController.swift
//  APISound
//
//  Created by archie on 15/6/11.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {
    var prettyFormatted = true
    
    var rawResponseString: String? {
        didSet {
            refreshText()
        }
    }
    var request: APIRequest!
    
    
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
        responseTextView.textContainerInset = UIEdgeInsetsMake(CGFloat(0),CGFloat(16) , CGFloat(0), CGFloat(16))
    }
    
    override func viewWillAppear(animated: Bool) {
        HttpFetcher().execute(request) { res in
            self.rawResponseString = res
        }
    }
    
    private func refreshText() -> Void {
        if let responseString = rawResponseString {
            responseTextView.text = prettyFormatted ? JSONStringify(responseString) : responseString
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
