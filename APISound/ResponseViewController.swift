//
//  ResponseViewController.swift
//  APISound
//
//  Created by archie on 15/6/11.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {
    @IBOutlet weak var responseTextView: UITextView!
    
    var fetch: (((String?) -> Void) -> Void)?

    override func viewWillAppear(animated: Bool) {
        fetch! { res in
            if let showRes = res {
                self.responseTextView.text = showRes
            }
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
