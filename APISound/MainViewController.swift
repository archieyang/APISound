//
//  MainViewController.swift
//  APISound
//
//  Created by archie on 15/5/24.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import JLToast

class MainViewController: UIViewController, MainUi {
    var mainPresenter = MainPresenter()
    var callbacks: MainUiCallbacks?
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var methodField: UITextField!
    @IBOutlet weak var methodPickerView: UIPickerView!
    @IBOutlet weak var urlParamsTableView: UITableView!
    
    let METHODS = HttpFetcher.METHODS
    
    var apiRequest: APIRequest? {
        didSet {
            if let request = apiRequest {
                urlField.text = request.url
                methodField.text = request.method
                self.urlParamsTableView.reloadData()
                
                if request !== mainPresenter.apiRequest! {
                    mainPresenter.apiRequest = request
                }
            }
        }
    }
    
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
    
        mainPresenter.attachUi(self)
        
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
    
    @IBAction func createNewRequest(sender: UIBarButtonItem) {
        self.apiRequest = callbacks!.createNewRequest()
    }
    
    @IBAction func addUrlParamPair(sender: UIButton) {
        showUrlParamDialog("Parameters", message: "Add URL Parameter", defaultUrlParams: nil) { (param) in
            self.callbacks!.addRequestParam(param)
            self.urlParamsTableView.reloadData()
        }
    }
    
    @IBAction func addHeader(sender: UIButton) {
        showUrlParamDialog("Headers", message: "Add Header Field", defaultUrlParams: nil) { (param) in
            self.callbacks!.addHeaderParam(param)
            self.urlParamsTableView.reloadData()
        }
        
    }
    @IBAction func sendRequest(sender: UIButton) {
        if let cb = callbacks {
            let (valid, warningText) = cb.isCurrentRequestValid()
            
            if valid {
                performSegueWithIdentifier("showResponse", sender: sender)
            } else {
                if let text = warningText {
                    JLToast.makeText(text).show()
                }
            }
            
        }
        
    }
    //MARK: Helper functions
    
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
        
        if let param = defaultUrlParams {
            okAction.enabled = true
        } else {
            okAction.enabled = false
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        var isKeyEmpty = true
        var isValueEmpty = true
        
        paramOperateController.addTextFieldWithConfigurationHandler { (keyTextField) in
            
            if let param = defaultUrlParams {
                keyTextField.text = param.key
            } else {
                keyTextField.placeholder = "Key"
            }
            
            isKeyEmpty = keyTextField.text.isEmpty
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: keyTextField, queue: NSOperationQueue.mainQueue()) { (_) in
                isKeyEmpty = keyTextField.text.isEmpty
                okAction.enabled = !isKeyEmpty && !isValueEmpty
            }
        }
        
        paramOperateController.addTextFieldWithConfigurationHandler { (valueTextField) in
            
            if let param = defaultUrlParams {
                valueTextField.text = param.value
            } else {
                valueTextField.placeholder = "Value"
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
    
    //MARK: MainUi
    
    func setCurrentItem(request: APIRequest) {
        apiRequest = request
    }
    
    func setUiCallbacks(c: BaseUiCallbacks) {
        if let mainUiCallacks = c as? MainUiCallbacks {
            callbacks = mainUiCallacks
        }

    }
    
    func getUrlString() -> String {
        return urlField.text
    }
    
    func getMethodString() -> String {
        return methodField.text
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResponse" {
            if let responseViewController = (segue.destinationViewController as? UINavigationController)?.topViewController as? ResponseViewController {
                callbacks?.saveCurrentRequest()
                responseViewController.request = apiRequest!
            }
        }
    }

    
}
