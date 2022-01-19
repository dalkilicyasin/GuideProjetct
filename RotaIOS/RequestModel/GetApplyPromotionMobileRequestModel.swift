//
//  GetApplyPromotionMobileRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 18.01.2022.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetApplyPromotionMobileRequestModel : Mappable{
    public var data : String!
    
    public required init?(map: Map) {
        
    }
    
    public init(  data : String) {
        self.data = data
    }
    
    public func mapping(map: Map) {
        data <- map["data"]
    }
}
