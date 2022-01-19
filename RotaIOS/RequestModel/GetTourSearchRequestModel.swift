//
//  GetTourSearchRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 25.11.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetTourSearchRequestModel : Mappable{
    public var Guide : Int!
    public var Market : Int!
    public var Hotel : Int!
    public var Area : Int!
    public var TourDateStart : String!
    public var TourDateEnd : String!
    public var SaleDate : String!
    public var TourType = "0"
    public var IsofficeSale = true
    public var PromotionId : Int!
    public var TourId = 0
   
    public required init?(map: Map) {
        
    }
    
    public init( Guide : Int, Market : Int, Hotel : Int, Area : Int, TourDateStart : String, TourDateEnd : String, SaleDate : String, PromotionId : Int) {
        self.Guide = Guide
        self.Market = Market
        self.Hotel = Hotel
        self.Area = Area
        self.TourDateStart = TourDateStart
        self.TourDateEnd = TourDateEnd
        self.SaleDate = SaleDate
        self.PromotionId = PromotionId
    }
    
    public func mapping(map: Map) {
        Guide <- map["Guide"]
        Market <- map["Market"]
        Hotel <- map["Hotel"]
        Area <- map["Area"]
        TourDateStart <- map["TourDateStart"]
        TourDateEnd <- map["TourDateEnd"]
        SaleDate <- map["SaleDate"]
        TourType <- map["TourType"]
        IsofficeSale <- map["IsofficeSale"]
        PromotionId <- map["PromotionId"]
        TourId <- map["TourId"]
    }
}
