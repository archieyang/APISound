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
    
    var mCurrentPart: ResponsePart!
    
    var mResponse: APIResponse? {
        didSet {
            refreshText()
        }
    }
    
    var mRequest: APIRequest!
    
    var mResponsePresenter: ResponsePresenter!
    
    @IBOutlet weak var prettySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var responseTextView: UITextView!
    
    @IBOutlet weak var responseStatusLine: UILabel!
    @IBOutlet weak var responseStatusLineView: UIView!

    @IBOutlet weak var noResponseHintLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBAction func back(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func formatChanged(sender: UISegmentedControl) {
        mCurrentPart = ResponsePart(rawValue: sender.selectedSegmentIndex)
        
        refreshText()
    }

    
    override func viewDidLoad() {
        mCurrentPart = .Body
        responseTextView.textContainerInset = UIEdgeInsetsMake(CGFloat(8),CGFloat(16) , CGFloat(8), CGFloat(16))
        noResponseHintLabel.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        mResponsePresenter = ResponsePresenter(apiRequest: mRequest)
        mResponsePresenter.attachUi(self)
    }
    
    //MARK: UIBottomBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        mCurrentPart = ResponsePart(rawValue: item.tag)
        refreshText()
    }
    
    //MARK: Helpers
    
    private func refreshText() -> Void {
        
        switch mCurrentPart! {
        case .Body:
            if let responseString = mResponse?.mBody {
                responseTextView.text = JSONStringify(responseString) ?? responseString
            } else {
                noResponseHintLabel.hidden = false
            }
            
        case .Headers:
            if let header = mResponse?.getFormattedHeader() {
                responseTextView.text = header
            } else {
                noResponseHintLabel.hidden = false
            }
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
        mResponse = resp
        if let status = mResponse?.getStatusLine() {
            responseStatusLine.text = status
        } else {
            responseStatusLineView.hidden = true
        }
    }
    
    func setLoadingIndicatorHidden(hidden: Bool) {
        loadingIndicator.hidden = hidden
    }
}
