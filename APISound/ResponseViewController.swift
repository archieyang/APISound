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
    
    var response: APIResponse? {
        didSet {
            refreshText()
        }
    }
    
    var request: APIRequest!
    
    var responsePresenter: ResponsePresenter!
    
    @IBOutlet weak var prettySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var responseTextView: UITextView!
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func formatChanged(sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            currentPart = ResponsePart(rawValue: 0)
//        case 1:
//            prettyFormatted = false
//        default:
//            prettyFormatted = false
//        }
        currentPart = ResponsePart(rawValue: sender.selectedSegmentIndex)
        
        refreshText()
    }

    
    override func viewDidLoad() {
        currentPart = .Body
        
        responseTextView.textContainerInset = UIEdgeInsetsMake(CGFloat(0),CGFloat(16) , CGFloat(0), CGFloat(16))
    }
    
    override func viewWillAppear(animated: Bool) {
        responsePresenter = ResponsePresenter(apiRequest: request)
        responsePresenter.attachUi(self)
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
            if let responseString = response?.body {
                responseTextView.text = JSONStringify(responseString) ?? responseString
            } else {
                responseTextView.text = "No Response"
            }
            
        case .Headers:
            responseTextView.text = response?.getFormattedHeader() ?? "No Response"
        }
    }
    
    private func JSONStringify(jsonString: String) -> String? {

        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) {
                if let formattedData = NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions.PrettyPrinted, error: nil) {
                    return NSString(data:formattedData, encoding: NSUTF8StringEncoding) as? String
                }
            }
        }
        
        return nil
    }

}

extension ResponseViewController: ResponseUi {
    func setUiCallbacks(callbacks: BaseUiCallbacks) {
        
    }
    
    func setResponse(resp: APIResponse?) {
        response = resp
    }
}
