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
        
        urlParamList.append(UrlParam(k:"key", v:"value"))
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
        var addParamController = UIAlertController(title: "Add URL parameter", message: "Please input key and value", preferredStyle: UIAlertControllerStyle.Alert)
        

        
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (_) in
            let keyTextField = addParamController.textFields![0] as! UITextField
            let valueTextField = addParamController.textFields![1] as! UITextField
            
            if keyTextField.text.isEmpty {
                return;
            }
            
            if valueTextField.text.isEmpty {
                return;
            }
            
            self.urlParamList.append(UrlParam(k: keyTextField.text, v: valueTextField.text))
            self.urlParamsTableView.reloadData()
        }
        addAction.enabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        var isKeyEmpty = true
        var isValueEmpty = true
        
        addParamController.addTextFieldWithConfigurationHandler { (keyTextField) in
            keyTextField.placeholder = "key"
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: keyTextField, queue: NSOperationQueue.mainQueue()) { (_) in
                isKeyEmpty = keyTextField.text.isEmpty
                addAction.enabled = !isKeyEmpty && !isValueEmpty
            }
        }
        
        addParamController.addTextFieldWithConfigurationHandler { (valueTextField) in
            valueTextField.placeholder = "value"
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: valueTextField, queue: NSOperationQueue.mainQueue()) { (_) in
                isValueEmpty = valueTextField.text.isEmpty
                addAction.enabled = !isKeyEmpty && !isValueEmpty
            }
        }
        

        
        
        addParamController.addAction(addAction)
        addParamController.addAction(cancelAction)
        
        self.presentViewController(addParamController, animated: true, completion: nil)
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
    
    //Mark: UITextViewDelegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        methodPickerView.hidden = false
        return false
    }
    
    //Mark: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlParamList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("urlParamCell", forIndexPath: indexPath) as! UrlParamCell
        cell.urlParam = urlParamList[indexPath.row]
        return cell
    }
    
}
