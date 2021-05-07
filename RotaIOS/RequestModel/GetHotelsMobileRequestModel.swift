//
//  GetHotelsMobileRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 6.05.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetHotelsMobileRequestModel : Mappable{
    
    public var guide : Int!
    public var saleDate : String!
    
    public required init?(map: Map) {
        
    }
    
    public init(userId:Int, saleDate:String) {
        self.guide = userId
        self.saleDate = saleDate
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guide=\(self.guide ?? 0)&saleDate=\(self.saleDate ?? "")"
    }
    
}
