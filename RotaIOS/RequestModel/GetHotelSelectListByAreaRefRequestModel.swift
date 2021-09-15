//
//  GetHotelSelectListByAreaRefRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.09.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetHotelSelectListByAreaRefRequestModel : Mappable{
    public var areaId : String!
  
    public required init?(map: Map) {
        
    }
    
    public init( areaId : String ) {
        self.areaId = areaId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?areaId=\(self.areaId ?? "")"
    }
}
