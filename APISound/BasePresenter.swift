//
//  BasePresenter.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public class BasePresenter {
    public typealias U = BaseUi
    
    var mUi : U!
    
    public init() {
        
    }
    
    public func attachUi(ui: U) -> Void {
        mUi = ui
        populateUi()
        onAttachToUi()
    }
    
    func populateUi() -> Void {
        
    }
    
    func onAttachToUi() -> Void {
        
    }
    
}

public protocol BaseUiCallbacks {
    
}