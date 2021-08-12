//
//  GetTourDetailForMobileResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 9.08.2021.
//

import Foundation
import ObjectMapper

struct GetTourDetailForMobileResponseModel : Mappable {
    var id : String?
    var Id : Int?
    var multiSaleId : Int?
    var parentVoucher : String?
    var tourVoucher : String?
    var tourPlanId : Int?
    var state : Int?
    var tourPickupTime : String?
    var manuelPickUpTime : String?
    var stateStr : String?
    var tourName : String?
    var totalAmount : Double?
    var totalDiscount : Double?
    var transfers : String?
    var extras : String?
    var paxes : String?
    var currency : String?
    var hotelName : String?
    var saleGuidePhone : String?
    var colGuide : String?
    var colKokartGuide : String?
    var excGuide : String?
    var excKokartGuide : String?
    var delGuide : String?
    var delKokartGuide : String?
    var priceTypeDesc : String?
    var cancelDate : String?
    var totalPax : String?
    var pax_ResNo : String?
    var typeDesc : String?
    var hotelMeetingPoint : String?
    var extraDesc : String?
    var extraPax : String?
    var transferTypeDesc : String?
    var penaltyAmount : Double?
    var refundAmount : Double?
    var cancelStaff : String?
    var paymentStr : String?
    var note : String?
    var dateChangeNote : String?
    var room : String?
    var tourDateStr : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        Id <- map["Id"]
        multiSaleId <- map["MultiSaleId"]
        parentVoucher <- map["ParentVoucher"]
        tourVoucher <- map["TourVoucher"]
        tourPlanId <- map["TourPlanId"]
        state <- map["State"]
        tourPickupTime <- map["TourPickupTime"]
        manuelPickUpTime <- map["ManuelPickUpTime"]
        stateStr <- map["StateStr"]
        tourName <- map["TourName"]
        totalAmount <- map["TotalAmount"]
        totalDiscount <- map["TotalDiscount"]
        transfers <- map["Transfers"]
        extras <- map["Extras"]
        paxes <- map["Paxes"]
        currency <- map["Currency"]
        hotelName <- map["HotelName"]
        saleGuidePhone <- map["SaleGuidePhone"]
        colGuide <- map["ColGuide"]
        colKokartGuide <- map["ColKokartGuide"]
        excGuide <- map["ExcGuide"]
        excKokartGuide <- map["ExcKokartGuide"]
        delGuide <- map["DelGuide"]
        delKokartGuide <- map["DelKokartGuide"]
        priceTypeDesc <- map["PriceTypeDesc"]
        cancelDate <- map["CancelDate"]
        totalPax <- map["TotalPax"]
        pax_ResNo <- map["Pax_ResNo"]
        typeDesc <- map["TypeDesc"]
        hotelMeetingPoint <- map["HotelMeetingPoint"]
        extraDesc <- map["ExtraDesc"]
        extraPax <- map["ExtraPax"]
        transferTypeDesc <- map["TransferTypeDesc"]
        penaltyAmount <- map["PenaltyAmount"]
        refundAmount <- map["RefundAmount"]
        cancelStaff <- map["CancelStaff"]
        paymentStr <- map["PaymentStr"]
        note <- map["Note"]
        dateChangeNote <- map["DateChangeNote"]
        room <- map["Room"]
        tourDateStr <- map["TourDateStr"]
    }
}
