//
//  HistoryPresenter.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class HistoryPresenter: BasePresenter {

    override func populateUi() -> Void {
        APIRequestManager.sharedInstance.fetchAll { apiRequests in
            if let ui = self.mUi as? HistoryUi {
                ui.setGroups(self.groupRequests(apiRequests))
                ui.setItems(apiRequests)
            }
        }
    }
    
    private func groupRequests(apiRequests: [APIRequest]) -> [HistorySectionItem] {
        var groups = [HistorySectionItem]()
        
        if apiRequests.count == 0 {
            return groups
        }
        
        var currentDate: NSDate = NSDate()
        
        var currentSize: Int = 1
        
        for index in 0 ..< apiRequests.count {
            
            let request = apiRequests[index]
            
            if index == 0 {
                currentDate = request.lastRequestTime
                currentSize = 1
            } else if request.lastRequestTime.inSameDay(currentDate) {
                currentSize += 1
            } else {
                groups.append(HistorySectionItem(size: currentSize, date: formatDate(currentDate)))
                currentSize = 1
                currentDate = request.lastRequestTime
            }
            
            if index == apiRequests.count - 1 {
                groups.append(HistorySectionItem(size: currentSize, date: formatDate(currentDate)))
            }
        }
        
        return groups
    }
    
    private func formatDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        return dateFormatter.stringFromDate(date)
    }

}

extension NSDate {
    func inSameDay(date: NSDate) -> Bool {
        let cal = NSCalendar.currentCalendar()
        var otherDateComponent = cal.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: date)
        var selfDateComponent = cal.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        
        return selfDateComponent.year == otherDateComponent.year
            && selfDateComponent.month == otherDateComponent.month
            && selfDateComponent.day == otherDateComponent.day
        
    }
}

struct HistorySectionItem {
    let mSize: Int
    let mDate: String
    
    init(size:Int, date: String) {
        mSize = size
        mDate = date
    }
}