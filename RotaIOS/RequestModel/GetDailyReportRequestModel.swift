//
//  GetDailyReportRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.10.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetDailyReportRequestModel : Mappable{
    public var guideId : String!
    public var date : String!
    
    public required init?(map: Map) {
        
    }
    
    public init( guideId : String, date : String) {
        self.guideId = guideId
        self.date = date
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideId=\(self.guideId ?? "")&date=\(self.date ?? "")"
    }
}
