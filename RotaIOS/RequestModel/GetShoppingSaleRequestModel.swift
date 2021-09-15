//
//  GetShoppingSaleRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetShoppingSaleRequestModel : Mappable{
    public var guideId : Int!
    public var begindate : String!
    public var endDate : String!
    public var hotelId : Int!
    
    public required init?(map: Map) {
        
    }
    
    public init( begindate : String, guideId : Int, endDate : String, hotelId : Int) {
        self.begindate = begindate
        self.guideId = guideId
        self.endDate = endDate
        self.hotelId = hotelId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideId=\(self.guideId ?? 0)&begindate=\(self.begindate ?? "")&endDate=\(self.endDate ?? "")&hotelId=\(self.hotelId ?? 0)"
    }
}
