//
//  GetInHouseListRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 11.05.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetInHouseListRequestModel : Mappable{
    
    public var hotelId : String!
    public var marketId : String!
    
    public required init?(map: Map) {
        
    }
    
    public init(hotelId:String, marketId:String) {
        self.hotelId = hotelId
        self.marketId = marketId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?hotelId=\(self.hotelId ?? "")&saleDate=\(self.marketId ?? "")"
    }
    
}
