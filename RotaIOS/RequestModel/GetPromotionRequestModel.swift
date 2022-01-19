//
//  GetPromotionRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 18.01.2022.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetPromotionRequestModel : Mappable{
    public var hotelId : Int!
    public var marketId : Int!
    public var tourSaleDate : String!
    public var tourStartDate : String!
    public var tourEndDate : String!
    
    public required init?(map: Map) {
        
    }
    
    public init( hotelId : Int, marketId : Int, tourSaleDate : String, tourStartDate : String, tourEndDate : String) {
        self.hotelId = hotelId
        self.marketId = marketId
        self.tourSaleDate = tourSaleDate
        self.tourStartDate = tourStartDate
        self.tourEndDate = tourEndDate
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?hotelId=\(self.hotelId ?? 0)&marketId=\(self.marketId ?? 0)&tourSaleDate=\(self.tourSaleDate ?? "")&tourStartDate=\(self.tourStartDate ?? "")&tourEndDate=\(self.tourEndDate ?? "")"
    }
}
