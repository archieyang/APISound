//
//  MainViewController.swift
//  APISound
//
//  Created by archie on 15/5/24.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var methodField: UITextField!
    @IBOutlet weak var methodPickerView: UIPickerView!
    @IBOutlet weak var urlParamsTableView: UITableView!
    
    let METHODS = ["GET", "POST"]
    
    var urlParamList = [UrlParam]()
    
    var urlParamTableViewDelegate: UrlParamTableViewDelegate! {
        didSet {
            urlParamsTableView.delegate = urlParamTableViewDelegate
        }
    }
    
    var urlParamTableViewDataSource: UrlParamTableViewDataSource! {
        didSet {
            urlParamsTableView.dataSource = urlParamTableViewDataSource
        }
    }
    
    
    var methodPickerDataSource: MethodPickerDataSource! {
        didSet {
            methodPickerView.dataSource = methodPickerDataSource
        }
    }
    
    var methodPickerDelegate: MethodPickerDelegate! {
        didSet {
             methodPickerView.delegate = methodPickerDelegate
        }
    }
    
    var methodTextFieldDelegate: MethodTextFieldDelegate! {
        didSet {
            methodField.delegate = methodTextFieldDelegate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlParamTableViewDelegate = UrlParamTableViewDelegate(controller: self)
        urlParamTableViewDataSource = UrlParamTableViewDataSource(controller: self)
        methodPickerDataSource = MethodPickerDataSource(controller: self)
        methodPickerDelegate = MethodPickerDelegate(controller: self) { row in
            self.methodField.text = self.METHODS[row]
            self.methodPickerView.hidden = true
        }
        
        methodTextFieldDelegate = MethodTextFieldDelegate {
            self.methodPickerView.hidden = false
            return false
        }
        
        
        methodPickerView.hidden = true
        methodField.text = METHODS[0]
    }
    

    @IBAction func showHistory(sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }

    @IBAction func showAbout(sender: UIBarButtonItem) {
        self.slideMenuController()?.openRight()
    }
    
    
    @IBAction func addUrlParamPair(sender: UIButton) {
        showUrlParamDialog("Add parameters", message: "Add URL parameter", defaultUrlParams: nil){ (param) in
            self.urlParamList.append(param)
            self.urlParamsTableView.reloadData()
        }
    }
    
//    @IBAction func sendRequest(sender: UIButton) {
//        urlParamsTableView.reloadData()
//        
//        HttpFetcher().fetch(urlField.text, urlParamList: urlParamList) {
//            (string) in
//            println(string)
//        }
//    }
    
    //MARK: Helper functions
    
    func getUrlParam(atIndex index: Int) -> UrlParam? {
        if index < 0 {
            return nil
        }
        
        if index >= urlParamList.count {
            return nil
        }
        
        return urlParamList[index]
    }
    
    func showUrlParamDialog(title: String , message: String, defaultUrlParams: UrlParam?, actionCallback: (UrlParam) -> Void) {
        var paramOperateController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default) { (_) in
            
            let keyTextField = paramOperateController.textFields![0] as! UITextField
            let valueTextField = paramOperateController.textFields![1] as! UITextField
            
            if keyTextField.text.isEmpty {
                return;
            }
            
            if valueTextField.text.isEmpty {
                return;
            }
            
            actionCallback(UrlParam(k: keyTextField.text, v: valueTextField.text))
        }
        
        okAction.accessibilityLabel = "OK"
        
        if let param = defaultUrlParams {
            okAction.enabled = true
        } else {
            okAction.enabled = false
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        cancelAction.accessibilityLabel = "Add URL Params Cancel"
        
        var isKeyEmpty = true
        var isValueEmpty = true
        
        paramOperateController.addTextFieldWithConfigurationHandler { (keyTextField) in
            keyTextField.accessibilityLabel = "URL param key"
            
            if let param = defaultUrlParams {
                keyTextField.text = param.key
            } else {
                keyTextField.placeholder = "key"
            }
            
            isKeyEmpty = keyTextField.text.isEmpty
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: keyTextField, queue: NSOperationQueue.mainQueue()) { (_) in
                isKeyEmpty = keyTextField.text.isEmpty
                okAction.enabled = !isKeyEmpty && !isValueEmpty
            }
        }
        
        paramOperateController.addTextFieldWithConfigurationHandler { (valueTextField) in
            valueTextField.accessibilityLabel = "URL param value"
            
            if let param = defaultUrlParams {
                valueTextField.text = param.value
            } else {
                valueTextField.placeholder = "value"
            }
            
            isValueEmpty = valueTextField.text.isEmpty
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: valueTextField, queue: NSOperationQueue.mainQueue()) { (_) in
                isValueEmpty = valueTextField.text.isEmpty
                okAction.enabled = !isKeyEmpty && !isValueEmpty
            }
        }
        
        paramOperateController.addAction(okAction)
        paramOperateController.addAction(cancelAction)
        
        self.presentViewController(paramOperateController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResponse" {
            if let responseViewController = (segue.destinationViewController as? UINavigationController)?.topViewController as? ResponseViewController {
                responseViewController.fetch = request
            }
        }
    }
    
    func request(callback: (String?) -> Void) ->Void {
        let newRequestDataItem = NSEntityDescription.insertNewObjectForEntityForName("RequestDataItem", inManagedObjectContext: self.managedObjectContext!) as! RequestDataItem
        
        newRequestDataItem.url = urlField.text;
        newRequestDataItem.method = methodField.text
        
        HttpFetcher().fetch(urlField.text, urlParamList: urlParamList) { (string) in
            callback(string)
        }
    }

    
}
