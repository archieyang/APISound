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
    @IBOutlet weak var urlParams: UITableView!
    
    let METHODS = ["GET","POST", "PUT", "DELETE", "HEAD", "OPTIONS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        methodField.delegate = self
        
        methodPickerView.hidden = true
        methodPickerView.delegate = self
        methodPickerView.dataSource = self
        
        
        urlParams.dataSource = self
        urlParams.delegate = self
        urlParams.hidden = true
        
        methodField.text = METHODS[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showHistory(sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }

    @IBAction func showAbout(sender: UIBarButtonItem) {
        self.slideMenuController()?.openRight()
    }
    
    @IBAction func addUrlParams(sender: UIButton) {
        urlParams.hidden = !urlParams.hidden
    }
    
    @IBAction func addUrlParam(sender: UIButton) {
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
        return METHODS.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("urlParamCell", forIndexPath: indexPath) as! UrlParamCell
        
        
        cell.paramKey.text = METHODS[indexPath.row]
        return cell
    }
    
    

}
