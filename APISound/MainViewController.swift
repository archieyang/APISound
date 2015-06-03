//
//  MainViewController.swift
//  APISound
//
//  Created by archie on 15/5/24.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var methodField: UITextField!
    @IBOutlet weak var methodPickerView: UIPickerView!
    @IBOutlet weak var urlParamsTableView: UITableView!
    
    let METHODS = ["GET","POST", "PUT", "DELETE", "HEAD", "OPTIONS"]
    
    var urlParamList = [UrlParam]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        methodField.delegate = self
        
        methodPickerView.hidden = true
        methodPickerView.delegate = self
        methodPickerView.dataSource = self
        
        
        urlParamsTableView.dataSource = self
        urlParamsTableView.delegate = self
        urlParamsTableView.hidden = true
        
        methodField.text = METHODS[0]
    }
    

    @IBAction func showHistory(sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }

    @IBAction func showAbout(sender: UIBarButtonItem) {
        self.slideMenuController()?.openRight()
    }
    
    @IBAction func showUrlParamsTable(sender: UIButton) {
        urlParamsTableView.hidden = !urlParamsTableView.hidden
    }
    
    @IBAction func addUrlParamPair(sender: UIButton) {
        showUrlParamDialog("Add", message: "Add URL parameter", defaultUrlParams: nil){ (param) in
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
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlParamList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("urlParamCell", forIndexPath: indexPath) as! UrlParamCell
        cell.urlParam = urlParamList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            urlParamList.removeAtIndex(indexPath.row)
            urlParamsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }

        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showUrlParamDialog("Edit", message: "Edit URL parameter", defaultUrlParams: urlParamList[indexPath.row]){ (param) in
            self.urlParamList[indexPath.row] = param
            self.urlParamsTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //MARK: Helper functions
    
    private func showUrlParamDialog(title: String , message: String, defaultUrlParams: UrlParam?, actionCallback: (UrlParam) -> Void) {
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
