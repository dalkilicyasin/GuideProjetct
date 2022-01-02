//
//  GetSaveMobileSaleRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 30.12.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetSaveMobileSaleRequestModel : Mappable{
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
