//
//  GetCacelRulesRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 29.08.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetCancelRulesRequestModel : Mappable{
    public var saleId : Int!
  
    public required init?(map: Map) {
        
    }
    
    public init( saleId : Int) {
        self.saleId = saleId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?saleId=\(self.saleId ?? 0)"
    }
}
