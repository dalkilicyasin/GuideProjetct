//
//  GetZReportPreviewRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 7.11.2021.
//


import Foundation
import UIKit
import ObjectMapper

public class  GetZReportPreviewRequestModel : Mappable{
    public var guideId : String!
    public var date : String!
    public var guideRegistrationNumber : String!
    
    public required init?(map: Map) {
        
    }
    
    public init( guideId : String, date : String, guideRegistrationNumber : String) {
        self.guideId = guideId
        self.date = date
        self.guideRegistrationNumber = guideRegistrationNumber
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideId=\(self.guideId ?? "")&date=\(self.date ?? "")&guideRegistrationNumber=\(self.guideRegistrationNumber ?? "")"
    }
}
