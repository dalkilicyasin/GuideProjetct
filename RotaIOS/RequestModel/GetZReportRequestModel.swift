//
//  GetZReportRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 20.09.2021.


import Foundation
import UIKit
import ObjectMapper

public class  GetZReportRequestModel : Mappable{
    public var reportCreateDateStart : String!
    public var reportCreateDateEnd : String!
    public var zReportNumber : String!
    public var guideId : String!
  
    public required init?(map: Map) {
        
    }
    
    public init( reportCreateDateStart : String, reportCreateDateEnd : String, zReportNumber : String, guideId : String) {
        self.reportCreateDateStart = reportCreateDateStart
        self.reportCreateDateEnd = reportCreateDateEnd
        self.zReportNumber = zReportNumber
        self.guideId = guideId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?reportCreateDateStart=\(self.reportCreateDateStart ?? "")&reportCreateDateEnd=\(self.reportCreateDateEnd ?? "")&zReportNumber=\(self.zReportNumber ?? "")&guideId=\(self.guideId ?? "")"
    }
}
