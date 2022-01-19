//
//  GetApplyPromotionMobileResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 18.01.2022.
//

import Foundation
import ObjectMapper

struct GetApplyPromotionMobileResponseModel : Mappable, Decodable, Encodable {
    var id : String?
    var record : Records?
    var isSuccesful : Bool?
    var resultKey : String?
    var message : String?
    var detailMessage : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        record <- map["Record"]
        isSuccesful <- map["IsSuccesful"]
        resultKey <- map["ResultKey"]
        message <- map["Message"]
        detailMessage <- map["DetailMessage"]
    }

}

struct Records : Mappable, Decodable, Encodable {
    var id : String?
    var promotionId : Int?
    var tours : [Tours]?
    var promotionDiscount : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        promotionId <- map["PromotionId"]
        tours <- map["tours"]
        promotionDiscount <- map["PromotionDiscount"]
    }
}

struct Tours : Mappable, Decodable, Encodable {
    var id : String?
    var tourId : Int?
    var tourDate : String?
    var priceType : Int?
    var adultAmount : Double?
    var childAmount : Double?
    var toodleAmount : Double?
    var infantAmount : Double?
    var paxTotalAmount : Double?
    var totalAmount : Double?
    var tourAmount : Double?
    var adl : Int?
    var chd : Int?
    var tdl : Int?
    var inf : Int?
    var promotionDiscount : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        tourId <- map["TourId"]
        tourDate <- map["TourDate"]
        priceType <- map["PriceType"]
        adultAmount <- map["AdultAmount"]
        childAmount <- map["ChildAmount"]
        toodleAmount <- map["ToodleAmount"]
        infantAmount <- map["InfantAmount"]
        paxTotalAmount <- map["PaxTotalAmount"]
        totalAmount <- map["TotalAmount"]
        tourAmount <- map["TourAmount"]
        adl <- map["Adl"]
        chd <- map["Chd"]
        tdl <- map["Tdl"]
        inf <- map["Inf"]
        promotionDiscount <- map["PromotionDiscount"]
    }
}

class TourPromotionPost: Mappable, Decodable, Encodable {
    var PromotionDiscount : Int?
    var tours : [TourRequestModel]?
    var PromotionId : Int?
    
    public init(PromotionDiscount : Int,  PromotionId : Int,  tours : [TourRequestModel]) {
        self.PromotionDiscount = PromotionDiscount
        self.tours = tours
        self.PromotionId = PromotionId
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        PromotionDiscount <- map["PromotionDiscount"]
        tours <- map["tours"]
        PromotionId <- map["PromotionId"]
    }
}

class TourRequestModel : Mappable, Decodable, Encodable {
    var Adl : Int?
    var AdultAmount : Double?
    var Chd : Int?
    var ChildAmount : Double?
    var Inf : Int?
    var InfantAmount : Double?
    var PaxTotalAmount : Double?
    var PlanId : Int?
    var PriceType : Int?
    var PromotionDiscount : Double?
    var Tdl : Int?
    var ToodleAmount : Double?
    var TotalAmount : Double?
    var TourAmount : Double?
    var TourDate : String?
    var TourId : Int?
 
    public init(Adl : Int,  AdultAmount : Double, Chd : Int, ChildAmount : Double, Inf : Int, InfantAmount : Double, PaxTotalAmount : Double,  PlanId : Int, PriceType : Int, PromotionDiscount : Double, Tdl : Int, ToodleAmount : Double, TotalAmount : Double, TourAmount : Double, TourDate : String, TourId : Int ) {
        
        self.Adl = Adl
        self.AdultAmount = AdultAmount
        self.Chd = Chd
        self.ChildAmount = ChildAmount
        self.Inf = Inf
        self.InfantAmount = InfantAmount
        self.PaxTotalAmount = PaxTotalAmount
        self.PlanId = PlanId
        self.PriceType = PriceType
        self.PromotionDiscount = PromotionDiscount
        self.Tdl = Tdl
        self.ToodleAmount = ToodleAmount
        self.TotalAmount = TotalAmount
        self.TourAmount = TourAmount
        self.TourDate = TourDate
        self.TourId = TourId
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Adl <- map["Adl"]
        AdultAmount <- map["AdultAmount"]
        Chd <- map["Chd"]
        ChildAmount <- map["ChildAmount"]
        Inf <- map["Inf"]
        InfantAmount <- map["InfantAmount"]
        PaxTotalAmount <- map["PaxTotalAmount"]
        PlanId <- map["PlanId"]
        PriceType <- map["PriceType"]
        PromotionDiscount <- map["PromotionDiscount"]
        Tdl <- map["Tdl"]
        ToodleAmount <- map["ToodleAmount"]
        TotalAmount <- map["TotalAmount"]
        TourAmount <- map["TourAmount"]
        TourDate <- map["TourDate"]
        TourId <- map["TourId"]
    }
}
