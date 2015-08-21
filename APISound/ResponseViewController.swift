//
//  ResponseViewController.swift
//  APISound
//
//  Created by archie on 15/6/11.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {
    enum ResponsePart: Int {
        case Body = 0, Headers
    }
    
    var mCurrentPart: ResponsePart!
    var mCallbacks: ResponseUiCallbacks!
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
    
    //MARK: Helpers
    
    private func refreshText() -> Void {
        
        switch mCurrentPart! {
        case .Body:
            mCallbacks.onShowBody()
        case .Headers:
            mCallbacks.onShowHeaders()
        }
    }
}

extension ResponseViewController: ResponseUi {

    func setUiCallbacks(callbacks: BaseUiCallbacks) {
        mCallbacks = callbacks as! ResponseUiCallbacks
    }
    
    func setStatusLine(statusLine: String?) {
        if let status = statusLine {
            responseStatusLine.text = status
        } else {
            responseStatusLineView.hidden = true
        }
    }
    
    func setHeaders(formattedHeaders: String?) {
        if let header = formattedHeaders {
            responseTextView.text = header
        } else {
            noResponseHintLabel.hidden = false
        }
    }
    
    func setBody(body: String?) {
        if let responseString = body {
            responseTextView.text = body
        } else {
            noResponseHintLabel.hidden = false
        }
    }
    
    func setLoadingIndicatorHidden(hidden: Bool) {
        loadingIndicator.hidden = hidden
    }
}

extension ResponseViewController: UITabBarDelegate {
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        mCurrentPart = ResponsePart(rawValue: item.tag)
        refreshText()
    }
}
