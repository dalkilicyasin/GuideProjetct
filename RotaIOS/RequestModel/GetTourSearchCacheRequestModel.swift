//
//  GetTourSearchCache.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.11.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetTourSearchCacheRequestModel : Mappable{
    public var guideId : String!
    public var hotelIds : String!
   
    public required init?(map: Map) {
        
    }
    
    public init( guideId : String, hotelIds : String) {
        self.guideId = guideId
        self.hotelIds = hotelIds
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideId=\(self.guideId ?? "")&hotelIds=\(self.hotelIds ?? "")"
    }
}
