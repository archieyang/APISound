//
//  MainViewController.swift
//  APISound
//
//  Created by archie on 15/5/24.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var methodField: UITextField!
    @IBOutlet weak var methodPickerView: UIPickerView!
    @IBOutlet weak var urlParamsTableView: UITableView!
    
    let METHODS = ["GET","POST", "PUT", "DELETE", "HEAD", "OPTIONS"]
    
    var urlParamList = [UrlParam]()
    
    var urlParamTableViewDelegate: UrlParamTableViewDelegate!
    var urlParamTableViewDataSource: UrlParamTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlParamTableViewDelegate = UrlParamTableViewDelegate(controller: self)
        urlParamTableViewDataSource = UrlParamTableViewDataSource(controller: self)
        
        methodField.delegate = self
        
        methodPickerView.hidden = true
        methodPickerView.delegate = self
        methodPickerView.dataSource = self
        
        urlParamsTableView.dataSource = urlParamTableViewDataSource
        urlParamsTableView.delegate = urlParamTableViewDelegate
        
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
    
    @IBAction func sendRequest(sender: UIButton) {
        urlParamsTableView.reloadData()
        
        HttpFetcher().fetch(urlField.text, urlParamList: urlParamList) {
            (string) in
            println(string)
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
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return METHODS.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return METHODS[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        methodField.text = METHODS[row]
        pickerView.hidden = true
    }
    
    //MARK: UITextViewDelegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        methodPickerView.hidden = false
        return false
    }
    
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
    
}
