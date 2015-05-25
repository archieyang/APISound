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
    
    let METHODS = ["GET","POST", "PUT", "DELETE", "HEAD", "OPTIONS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        methodPickerView.hidden = true
        methodField.delegate = self
        methodPickerView.delegate = self
        methodPickerView.dataSource = self
        
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

}
