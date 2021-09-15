//
//  GetSpeakTimeForMobileRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 15.09.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetSpeakTimeForMobileRequestModel : Mappable{
    public var HotelId : String!
    public var date : String!
    public var guideId : String!
    public var areaId : String!
  
    public required init?(map: Map) {
        
    }
    
    public init( HotelId : String, date : String, guideId : String, areaId : String) {
        self.HotelId = HotelId
        self.date = date
        self.guideId = guideId
        self.areaId = areaId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?HotelId=\(self.HotelId ?? "")&date=\(self.date ?? "")&guideId=\(self.guideId ?? "")&areaId=\(self.areaId ?? "")"
    }
}
