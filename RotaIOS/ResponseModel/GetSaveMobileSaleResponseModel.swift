//
//  GetSaveMobileSaleResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 29.12.2021.
//

import Foundation
import ObjectMapper


struct GetSaveMobileSaleResponseModel : Mappable {
    var Message : String?
    var IsSuccesful : Bool?
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        Message <- map["Message"]
        IsSuccesful <- map["IsSuccesful"]
    }
}

class TourSalePost : Mappable, Decodable, Encodable {
    var Multisale : Multisale?
    var PaxTourLists : [PaxTourList]?
    var Payments : [Payment]?
    var Paxes : [Paxes]?
    var IsOffline : String?
    var AllowDublicatePax : String?
    var TourList : [TourList]?
    
    
    public init(Multisale : Multisale,  PaxTourLists : [PaxTourList], Payments : [Payment], Paxes : [Paxes], IsOffline : String, AllowDublicatePax : String,TourList : [TourList]) {
        self.Multisale = Multisale
        self.TourList = TourList
        self.Payments = Payments
        self.Paxes = Paxes
        self.IsOffline = IsOffline
        self.AllowDublicatePax = AllowDublicatePax
        self.PaxTourLists = PaxTourLists
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Multisale <- map["Multisale"]
        PaxTourLists <- map["PaxTourLists"]
        Payments <- map["Payments"]
        Paxes <- map["Paxes"]
        IsOffline <- map["IsOffline"]
        AllowDublicatePax <- map["AllowDublicatePax"]
        TourList <- map["TourList"]
    } 
}



// TourSave classes

public class Multisale : Mappable, Decodable, Encodable {
    var CouponAmount : Int?
    var CouponId : Int?
    var CurrencyId : Int?
    var GuideId : Int?
    var HotelId : Int?
    var ID : Int?
    var IsMobile : Int?
    var IsOfficeSale : Bool?
    var ManualDiscount : Int?
    var MarketId    : Int?
    var Note : String?
    var PaidAmount : Int?
    var PromotionId : Int?
    var SaleDate : String?
    var TotalAmount : Int?
    
    public init(CouponAmount : Int, CouponId : Int, CurrencyId : Int, GuideId : Int, HotelId : Int, ID : Int, IsMobile : Int, IsOfficeSale : Bool, ManualDiscount : Int, MarketId : Int, Note : String, PaidAmount : Int, PromotionId : Int, SaleDate : String, TotalAmount : Int) {
        self.CouponAmount = CouponAmount
        self.CouponId = CouponId
        self.CurrencyId = CurrencyId
        self.GuideId = GuideId
        self.HotelId = HotelId
        self.ID = ID
        self.IsMobile = IsMobile
        self.IsOfficeSale = IsOfficeSale
        self.ManualDiscount = ManualDiscount
        self.MarketId = MarketId
        self.Note = Note
        self.PaidAmount = PaidAmount
        self.PromotionId = PromotionId
        self.SaleDate = SaleDate
        self.TotalAmount = TotalAmount
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        CouponAmount <- map["CouponAmount"]
        CouponId <- map["CouponId"]
        CurrencyId <- map["CurrencyId"]
        GuideId <- map["GuideId"]
        HotelId <- map["HotelId"]
        ID <- map["ID"]
        IsMobile <- map["IsMobile"]
        IsOfficeSale <- map["IsOfficeSale"]
        ManualDiscount <- map["ManualDiscount"]
        MarketId <- map["MarketId"]
        Note <- map["Note"]
        PaidAmount <- map["PaidAmount"]
        PromotionId <- map["PromotionId"]
        SaleDate <- map["SaleDate"]
        TotalAmount <- map["TotalAmount"]
    }
}

public class PaxTourList : Mappable, Decodable, Encodable {
    var AgeGroup : String?
    var Gender :  String?
    var ID :  String?
    var PlanId :  Int?
    
    public init(AgeGroup : String, Gender : String, ID : String, PlanId : Int) {
        self.AgeGroup = AgeGroup
        self.Gender = Gender
        self.ID = ID
        self.PlanId = PlanId
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        AgeGroup <- map["AgeGroup"]
        Gender <- map["Gender"]
        ID <- map["ID"]
        PlanId <- map["PlanId"]
    }
}

public class Payment : Mappable, Decodable, Encodable {
    var ByDesc : String?
    var ById :  String?
    var ConvertedCurrency :  String?
    var ConvertedPaymentAmount :  Int?
    var Currency : String?
    var CurrencyId :  String?
    var PaymentAmount :  Double?
    var PaymentType :  String?
    var TargetAmount : Int?
    var TypeId :  String?
    
    public init(ByDesc : String, ById : String, ConvertedCurrency : String, ConvertedPaymentAmount : Int, Currency : String, CurrencyId : String, PaymentAmount : Double, PaymentType : String, TargetAmount : Int, TypeId : String) {
        
        self.ByDesc = ByDesc
        self.ById = ById
        self.ConvertedCurrency = ConvertedCurrency
        self.ConvertedPaymentAmount = ConvertedPaymentAmount
        self.Currency = Currency
        self.CurrencyId = CurrencyId
        self.PaymentAmount = PaymentAmount
        self.PaymentType = PaymentType
        self.TargetAmount = TargetAmount
        self.TypeId = TypeId
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        ByDesc <- map["ByDesc"]
        ById <- map["ById"]
        CurrencyId <- map["CurrencyId"]
        ConvertedCurrency <- map["ConvertedCurrency"]
        ConvertedPaymentAmount <- map["ConvertedPaymentAmount"]
        Currency <- map["Currency"]
        CurrencyId <- map["CurrencyId"]
        PaymentAmount <- map["PaymentAmount"]
        PaymentType <- map["PaymentType"]
        TargetAmount <- map["TargetAmount"]
        TypeId <- map["TypeId"]
    }
}

public class TourList : Mappable, Decodable, Encodable {
    var id : Int?
    var AdultAmount : Double?
    var AdultCount : Int?
    var AdultPrice : Double?
    var ChildAmount : Double?
    var ChildCount : Int?
    var ChildPrice : Double?
    var InfantAmount : Double?
    var InfantCount : Int?
    var InfantPrice : Double?
    var ToodleAmount : Double?
    var ToodleCount : Int?
    var ToodlePrice : Double?
    var PromotionId : Int?
    var PoolType : Int?
    var PriceId : Int?
    var PlanId : Int?
    var TourType : Int?
    var TourName : String?
    var TourId : Int?
    var Currency : Int?
    var CurrencyDesc : String?
    var TourDateStr : String?
    var TourDate : String?
    var AllotmenStatus : Int?
    var RemainingAllotment : Int?
    var PriceType : Int?
    var MinPax : Double?
    var TotalPrice : Double?
    var FlatPrice : Double?
    var MinPrice : Double?
    var InfantAge1 : Double?
    var InfantAge2 : Double?
    var ToodleAge1 : Double?
    var ToodleAge2 : Double?
    var ChildAge1 : Double?
    var ChildAge2 : Double?
    var PickUpTime : String?
    var DetractAdult : Bool?
    var DetractChild : Bool?
    var DetractKid : Bool?
    var DetractInfant : Bool?
    var AskSell : Bool?
    var MeetingPointId : Int?
    var Paref : String?
    var TourCode : String?
    var ID : Int?
    var CREATEDDATE : String?
    var ExtraTourist : [Extras]?
    var TransferTourist : [Transfers]?
    var RefundCondition : String?
    var TicketCount : Int?
    var TourAmount : Double?
    var VoucherNo : String?
    
    
    public init( id : Int, AdultAmount : Double, AdultCount : Int, AdultPrice : Double, ChildAmount : Double, ChildCount : Int, ChildPrice : Double, InfantAmount : Double, InfantCount : Int, InfantPrice : Double, ToodleAmount : Double, ToodleCount : Int, ToodlePrice : Double, MatchId : Int, MarketId : Int, PromotionId : Int, PoolType : Int, PriceId : Int, PlanId : Int, TourType : Int, TourName : String, TourId : Int, Currency : Int, CurrencyDesc : String, TourDateStr : String, TourDate : String, AllotmenStatus : Int, RemainingAllotment : Int, PriceType : Int, MinPax : Double, TotalPrice : Double, FlatPrice : Double, MinPrice : Double, InfantAge1 : Double, InfantAge2 : Double, ToodleAge1 : Double, ToodleAge2 : Double, ChildAge1 : Double, ChildAge2 : Double, PickUpTime : String, DetractAdult : Bool, DetractChild : Bool, DetractKid : Bool, DetractInfant : Bool, AskSell : Bool, MeetingPointId : Int, Paref : String, TourCode : String, ID : Int, CREATEDDATE : String, RefundCondition : String,TicketCount : Int, TourAmount : Double, VoucherNo : String, ExtraTourist : [Extras], TransferTourist : [Transfers]) {
        
        self.id = id
        self.AdultAmount = AdultAmount
        self.AdultCount = AdultCount
        self.AdultPrice = AdultPrice
        self.ChildAmount = ChildAmount
        self.ChildCount = ChildCount
        self.ChildPrice = ChildPrice
        self.InfantAmount = InfantAmount
        self.InfantCount = InfantCount
        self.InfantPrice = InfantPrice
        self.ToodleAmount = ToodleAmount
        self.ToodleCount = ToodleCount
        self.ToodlePrice = ToodlePrice
        self.PromotionId = PromotionId
        self.PoolType = PoolType
        self.PriceId = PriceId
        self.PlanId = PlanId
        self.TourType = TourType
        self.TourName = TourName
        self.TourId = TourId
        self.Currency = Currency
        self.CurrencyDesc = CurrencyDesc
        self.TourDateStr = TourDateStr
        self.TourDate = TourDate
        self.AllotmenStatus = AllotmenStatus
        self.RemainingAllotment = RemainingAllotment
        self.PriceType = PriceType
        self.MinPax = MinPax
        self.TotalPrice = TotalPrice
        self.FlatPrice = FlatPrice
        self.MinPrice = MinPrice
        self.InfantAge1 = InfantAge1
        self.InfantAge2 = InfantAge2
        self.ToodleAge1 = ToodleAge1
        self.ToodleAge2 = ToodleAge2
        self.ChildAge1 = ChildAge1
        self.ChildAge2 = ChildAge2
        self.PickUpTime = PickUpTime
        self.DetractAdult = DetractAdult
        self.DetractChild = DetractChild
        self.DetractKid = DetractKid
        self.DetractInfant = DetractInfant
        self.AskSell = AskSell
        self.MeetingPointId = MeetingPointId
        self.Paref = Paref
        self.TourCode = TourCode
        self.ID = ID
        self.CREATEDDATE = CREATEDDATE
        self.RefundCondition = RefundCondition
        self.TicketCount = TicketCount
        self.TourAmount = TourAmount
        self.VoucherNo = VoucherNo
        self.ExtraTourist = ExtraTourist
        self.TransferTourist = TransferTourist
    }
    
   public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        AdultAmount <- map["AdultAmount"]
        AdultCount <- map["AdultCount"]
        AdultPrice <- map["AdultPrice"]
        ChildAmount <- map["ChildAmount"]
        ChildCount <- map["ChildCount"]
        ChildPrice <- map["ChildPrice"]
        InfantAmount <- map["InfantAmount"]
        InfantCount <- map["InfantCount"]
        InfantPrice <- map["InfantPrice"]
        ToodleAmount <- map["ToodleAmount"]
        ToodleCount <- map["ToodleCount"]
        ToodlePrice <- map["ToodlePrice"]
        PromotionId <- map["PromotionId"]
        PoolType <- map["PoolType"]
        PriceId <- map["PriceId"]
        PlanId <- map["PlanId"]
        TourType <- map["TourType"]
        TourName <- map["TourName"]
        TourId <- map["TourId"]
        Currency <- map["Currency"]
        CurrencyDesc <- map["CurrencyDesc"]
        TourDateStr <- map["TourDateStr"]
        TourDate <- map["TourDate"]
        AllotmenStatus <- map["AllotmenStatus"]
        RemainingAllotment <- map["RemainingAllotment"]
        PriceType <- map["PriceType"]
        MinPax <- map["MinPax"]
        TotalPrice <- map["TotalPrice"]
        FlatPrice <- map["FlatPrice"]
        MinPrice <- map["MinPrice"]
        InfantAge1 <- map["InfantAge1"]
        InfantAge2 <- map["InfantAge2"]
        ToodleAge1 <- map["ToodleAge1"]
        ToodleAge2 <- map["ToodleAge2"]
        ChildAge1 <- map["ChildAge1"]
        ChildAge2 <- map["ChildAge2"]
        PickUpTime <- map["PickUpTime"]
        DetractAdult <- map["DetractAdult"]
        DetractChild <- map["DetractChild"]
        DetractKid <- map["DetractKid"]
        DetractInfant <- map["DetractInfant"]
        AskSell <- map["AskSell"]
        MeetingPointId <- map["MeetingPointId"]
        Paref <- map["Paref"]
        TourCode <- map["TourCode"]
        ID <- map["ID"]
        CREATEDDATE <- map["CREATEDDATE"]
        RefundCondition <- map["RefundCondition"]
        TicketCount <- map["TicketCount"]
        TourAmount <- map["TourAmount"]
        VoucherNo <- map["VoucherNo"]
        TransferTourist <- map["TransferTourist"]
        ExtraTourist <- map["ExtraTourist"]
    }
}

/*
 
 id : String, AdultAmount : Int, AdultCount : Int, AdultPrice : Int, ChildAmount : Int, ChildCount : Int, ChildPrice : Int, InfantAmount : Int, InfantCount : Int, InfantPrice : Int, ToodleAmount : Int, ToodleCount : Int, ToodlePrice : Int, matchId : Int, marketId : Int, promotionId : Int, poolType : Int, priceId : Int, planId : Int, tourType : Int, tourName : String, tourId : Int, currency : Int, currencyDesc : String, tourDateStr : String, tourDateShort : String, allotmenStatus : Int, remainingAllotment : String, priceType : Int, minPax : Double, totalPrice : Double, flatPrice : Double, minPrice : Double, infantAge1 : Double, infantAge2 : Double, toodleAge1 : Double, toodleAge2 : Double, childAge1 : Double, childAge2 : Double, pickUpTime : String, detractAdult : Bool, detractChild : Bool, detractKid : Bool, detractInfant : Bool, askSell : Bool, meetingPointId : Int, paref : Int, tourCode : String, iD : Int, cREATEDDATE : String, RefundCondition : String, TicketCount : Int, TourAmount : Int, VoucherNo : String, ExtraTourist : [Extras], TransferTourist : [Transfers]
 */
