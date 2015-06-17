//
//  ResponseViewController.swift
//  APISound
//
//  Created by archie on 15/6/11.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {
    var rawResponseString: String? {
        didSet {
            responseTextView.text = rawResponseString
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
            self.responseTextView.text = "TODO: pretty response text"
        case 1:
            self.responseTextView.text = rawResponseString
        default:
            self.responseTextView.text = "TODO: pretty response text"
        }
    }
    

    override func viewDidLoad() {
        responseTextView.textContainerInset = UIEdgeInsetsMake(CGFloat(0),CGFloat(16) , CGFloat(0), CGFloat(16))
    }
    
    override func viewWillAppear(animated: Bool) {
        HttpFetcher().execute(request) { res in
            self.rawResponseString = res
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
