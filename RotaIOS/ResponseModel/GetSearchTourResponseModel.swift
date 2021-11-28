//
//  GetSearchTourResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 25.11.2021.
//

import Foundation
import ObjectMapper

struct GetSearchTourResponseModel : Mappable {
    var id : String?
    var matchId : Int?
    var marketId : Int?
    var hotelId : Int?
    var areaId : Int?
    var promotionId : Int?
    var poolType : Int?
    var priceId : Int?
    var planId : Int?
    var tourType : Int?
    var tourName : String?
    var tourId : Int?
    var currency : Int?
    var currencyDesc : String?
    var tourDate : String?
    var tourDateStr : String?
    var tourDateShort : String?
    var allotmenStatus : Int?
    var remainingAllotment : String?
    var priceType : Int?
    var priceTypeDesc : String?
    var adultPrice : Double?
    var childPrice : Double?
    var infantPrice : Double?
    var toodlePrice : Double?
    var minPax : Double?
    var totalPrice : Double?
    var flatPrice : Double?
    var minPrice : Double?
    var infantAge1 : Double?
    var infantAge2 : Double?
    var toodleAge1 : Double?
    var toodleAge2 : Double?
    var childAge1 : Double?
    var childAge2 : Double?
    var pickUpTime : String?
    var transfers : [Transfers]?
    var extras : [String]?
    var detractAdult : Bool?
    var detractChild : Bool?
    var detractKid : Bool?
    var detractInfant : Bool?
    var askSell : Bool?
    var conceptDesc : String?
    var meetingPointId : Int?
    var meetingPoint : String?
    var paref : Int?
    var tourCode : String?
    var saleChannel : String?
    var iD : Int?
    var title : String?
    var cREATEDDATE : String?
    var mODIFIEDDATE : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        matchId <- map["MatchId"]
        marketId <- map["MarketId"]
        hotelId <- map["HotelId"]
        areaId <- map["AreaId"]
        promotionId <- map["PromotionId"]
        poolType <- map["PoolType"]
        priceId <- map["PriceId"]
        planId <- map["PlanId"]
        tourType <- map["TourType"]
        tourName <- map["TourName"]
        tourId <- map["TourId"]
        currency <- map["Currency"]
        currencyDesc <- map["CurrencyDesc"]
        tourDate <- map["TourDate"]
        tourDateStr <- map["TourDateStr"]
        tourDateShort <- map["TourDateShort"]
        allotmenStatus <- map["AllotmenStatus"]
        remainingAllotment <- map["RemainingAllotment"]
        priceType <- map["PriceType"]
        priceTypeDesc <- map["PriceTypeDesc"]
        adultPrice <- map["AdultPrice"]
        childPrice <- map["ChildPrice"]
        infantPrice <- map["InfantPrice"]
        toodlePrice <- map["ToodlePrice"]
        minPax <- map["MinPax"]
        totalPrice <- map["TotalPrice"]
        flatPrice <- map["FlatPrice"]
        minPrice <- map["MinPrice"]
        infantAge1 <- map["InfantAge1"]
        infantAge2 <- map["InfantAge2"]
        toodleAge1 <- map["ToodleAge1"]
        toodleAge2 <- map["ToodleAge2"]
        childAge1 <- map["ChildAge1"]
        childAge2 <- map["ChildAge2"]
        pickUpTime <- map["PickUpTime"]
        transfers <- map["Transfers"]
        extras <- map["Extras"]
        detractAdult <- map["DetractAdult"]
        detractChild <- map["DetractChild"]
        detractKid <- map["DetractKid"]
        detractInfant <- map["DetractInfant"]
        askSell <- map["AskSell"]
        conceptDesc <- map["ConceptDesc"]
        meetingPointId <- map["MeetingPointId"]
        meetingPoint <- map["MeetingPoint"]
        paref <- map["Paref"]
        tourCode <- map["TourCode"]
        saleChannel <- map["SaleChannel"]
        iD <- map["ID"]
        title <- map["Title"]
        cREATEDDATE <- map["CREATEDDATE"]
        mODIFIEDDATE <- map["MODIFIEDDATE"]
    }
}

struct Transfers : Mappable {
    var id : String?
    var matchId : Int?
    var gID : String?
    var priceId : Int?
    var tourSaleId : Int?
    var productType : Int?
    var typeDesc : String?
    var tourName : String?
    var desc : String?
    var priceType : Int?
    var priceTypeDesc : String?
    var currency : Int?
    var currencyDesc : String?
    var adultPrice : Double?
    var childPrice : Double?
    var toodlePrice : Double?
    var infantPrice : Double?
    var flatPrice : Double?
    var minPax : Int?
    var minPrice : Double?
    var pickupTime : String?
    var adultAmount : Double?
    var childAmount : Double?
    var toodleAmount : Double?
    var infantAmount : Double?
    var totalAmount : Double?
    var adultCount : Int?
    var childCount : Int?
    var toodleCount : Int?
    var infantCount : Int?
    var itemCount : Int?
    var tourId : Int?
    var transferPlanId : Int?
    var tourPlanId : Int?
    var tourDate : String?
    var transferType : String?
    var adultCancel : String?
    var childCancel : String?
    var toodleCancel : String?
    var infantCancel : String?
    var transferTypeDesc : String?
    var paxList : String?
    var iD : Int?
    var action : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        matchId <- map["MatchId"]
        gID <- map["GID"]
        priceId <- map["PriceId"]
        tourSaleId <- map["TourSaleId"]
        productType <- map["ProductType"]
        typeDesc <- map["TypeDesc"]
        tourName <- map["TourName"]
        desc <- map["Desc"]
        priceType <- map["PriceType"]
        priceTypeDesc <- map["PriceTypeDesc"]
        currency <- map["Currency"]
        currencyDesc <- map["CurrencyDesc"]
        adultPrice <- map["AdultPrice"]
        childPrice <- map["ChildPrice"]
        toodlePrice <- map["ToodlePrice"]
        infantPrice <- map["InfantPrice"]
        flatPrice <- map["FlatPrice"]
        minPax <- map["MinPax"]
        minPrice <- map["MinPrice"]
        pickupTime <- map["PickupTime"]
        adultAmount <- map["AdultAmount"]
        childAmount <- map["ChildAmount"]
        toodleAmount <- map["ToodleAmount"]
        infantAmount <- map["InfantAmount"]
        totalAmount <- map["TotalAmount"]
        adultCount <- map["AdultCount"]
        childCount <- map["ChildCount"]
        toodleCount <- map["ToodleCount"]
        infantCount <- map["InfantCount"]
        itemCount <- map["ItemCount"]
        tourId <- map["TourId"]
        transferPlanId <- map["TransferPlanId"]
        tourPlanId <- map["TourPlanId"]
        tourDate <- map["TourDate"]
        transferType <- map["TransferType"]
        adultCancel <- map["AdultCancel"]
        childCancel <- map["ChildCancel"]
        toodleCancel <- map["ToodleCancel"]
        infantCancel <- map["InfantCancel"]
        transferTypeDesc <- map["TransferTypeDesc"]
        paxList <- map["PaxList"]
        iD <- map["ID"]
        action <- map["Action"]
    }
}

struct Extras : Mappable {
    var id : String?
    var matchId : Int?
    var gID : String?
    var priceId : Int?
    var tourSaleId : Int?
    var productType : Int?
    var typeDesc : String?
    var tourName : String?
    var desc : String?
    var priceType : Int?
    var priceTypeDesc : String?
    var currency : Int?
    var currencyDesc : String?
    var adultPrice : Double?
    var childPrice : Double?
    var toodlePrice : Double?
    var infantPrice : Double?
    var flatPrice : Double?
    var minPax : Int?
    var minPrice : Double?
    var pickupTime : String?
    var adultAmount : Double?
    var childAmount : Double?
    var toodleAmount : Double?
    var infantAmount : Double?
    var totalAmount : Double?
    var adultCount : Int?
    var childCount : Int?
    var toodleCount : Int?
    var infantCount : Int?
    var itemCount : Int?
    var tourId : Int?
    var transferPlanId : Int?
    var tourPlanId : Int?
    var tourDate : String?
    var transferType : String?
    var adultCancel : String?
    var childCancel : String?
    var toodleCancel : String?
    var infantCancel : String?
    var transferTypeDesc : String?
    var paxList : String?
    var iD : Int?
    var action : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        matchId <- map["MatchId"]
        gID <- map["GID"]
        priceId <- map["PriceId"]
        tourSaleId <- map["TourSaleId"]
        productType <- map["ProductType"]
        typeDesc <- map["TypeDesc"]
        tourName <- map["TourName"]
        desc <- map["Desc"]
        priceType <- map["PriceType"]
        priceTypeDesc <- map["PriceTypeDesc"]
        currency <- map["Currency"]
        currencyDesc <- map["CurrencyDesc"]
        adultPrice <- map["AdultPrice"]
        childPrice <- map["ChildPrice"]
        toodlePrice <- map["ToodlePrice"]
        infantPrice <- map["InfantPrice"]
        flatPrice <- map["FlatPrice"]
        minPax <- map["MinPax"]
        minPrice <- map["MinPrice"]
        pickupTime <- map["PickupTime"]
        adultAmount <- map["AdultAmount"]
        childAmount <- map["ChildAmount"]
        toodleAmount <- map["ToodleAmount"]
        infantAmount <- map["InfantAmount"]
        totalAmount <- map["TotalAmount"]
        adultCount <- map["AdultCount"]
        childCount <- map["ChildCount"]
        toodleCount <- map["ToodleCount"]
        infantCount <- map["InfantCount"]
        itemCount <- map["ItemCount"]
        tourId <- map["TourId"]
        transferPlanId <- map["TransferPlanId"]
        tourPlanId <- map["TourPlanId"]
        tourDate <- map["TourDate"]
        transferType <- map["TransferType"]
        adultCancel <- map["AdultCancel"]
        childCancel <- map["ChildCancel"]
        toodleCancel <- map["ToodleCancel"]
        infantCancel <- map["InfantCancel"]
        transferTypeDesc <- map["TransferTypeDesc"]
        paxList <- map["PaxList"]
        iD <- map["ID"]
        action <- map["Action"]
    }
}

