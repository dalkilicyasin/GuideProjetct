//
//  GetExhangeRatesRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 24.12.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetExhangeRatesRequestModel : Mappable{
    public var date : String!
   
    public required init?(map: Map) {
        
    }
    
    public init( date : String) {
        self.date = date
      
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?date=\(self.date ?? "")"
    }
}
