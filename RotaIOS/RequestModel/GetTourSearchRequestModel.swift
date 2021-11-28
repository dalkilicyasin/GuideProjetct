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
 
    
    public var guide : String!
    public var market : String!
    public var hotel : String!
    public var area : String!
    public var tourdatestart : String!
    public var tourdateend : String!
    public var saledate : String!
    public var tourtype = "0"
    public var isofficesale = true
    public var promotionid = "0"
    public var tourid = "0"
   
    public required init?(map: Map) {
        
    }
    
    public init( guide : String, market : String, hotel : String, area : String, tourdatestart : String, tourdateend : String, saledate : String) {
        self.guide = guide
        self.market = market
        self.hotel = hotel
        self.area = area
        self.tourdatestart = tourdatestart
        self.tourdateend = tourdateend
        self.saledate = saledate
    }
    
    public func mapping(map: Map) {
        guide <- map["guide"]
        market <- map["market"]
        hotel <- map["hotel"]
        area <- map["area"]
        tourdatestart <- map["tourdatestart"]
        tourdateend <- map["tourdateend"]
        saledate <- map["saledate"]
        tourtype <- map["tourtype"]
        isofficesale <- map["isofficesale"]
        promotionid <- map["promotionid"]
        promotionid <- map["promotionid"]
        tourid <- map["tourid"]
    }

}
