//
//  GetVoucherDetailResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 26.08.2021.
//

import Foundation
import ObjectMapper

struct GetVoucherDetailResponseModel : Mappable {
    var id : String?
    var saleId : Int?
    var tourTypeDesc : String?
    var tourName : String?
    var voucherNo : String?
    var tourId : Int?
    var tourDateStr : String?
    var pickupTime : String?
    var hotelId : Int?
    var hotelName : String?
    var totalAmount : Double?
    var currencyId : Int?
    var currencyDesc : String?
    var couponAmount : Double?
    var guideId : Int?
    var tourPlanId : Int?
    var cancelDate : String?
    var saleDate : String?
    var pax_ResNo : String?
    var guide : String?
    var tourist : String?
    var touristId : String?
    var tourDate : String?
    var operatorName : String?
    var room : String?
    var freeTotalPax : String?
    var totalPaxName : String?
    var totalPax : String?
    var extraDesc : String?
    var transferDesc : String?
    var transferTotalPax : String?
    var transferTotalAmount : Double?
    var couponNumber : String?

    init?(map: Map) {

    }
    
    init() {
        
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        saleId <- map["SaleId"]
        tourTypeDesc <- map["TourTypeDesc"]
        tourName <- map["TourName"]
        voucherNo <- map["VoucherNo"]
        tourId <- map["TourId"]
        tourDateStr <- map["TourDateStr"]
        pickupTime <- map["PickupTime"]
        hotelId <- map["HotelId"]
        hotelName <- map["HotelName"]
        totalAmount <- map["TotalAmount"]
        currencyId <- map["CurrencyId"]
        currencyDesc <- map["CurrencyDesc"]
        couponAmount <- map["CouponAmount"]
        guideId <- map["GuideId"]
        tourPlanId <- map["TourPlanId"]
        cancelDate <- map["CancelDate"]
        saleDate <- map["SaleDate"]
        pax_ResNo <- map["Pax_ResNo"]
        guide <- map["Guide"]
        tourist <- map["Tourist"]
        touristId <- map["TouristId"]
        tourDate <- map["TourDate"]
        operatorName <- map["Operator"]
        room <- map["Room"]
        freeTotalPax <- map["FreeTotalPax"]
        totalPaxName <- map["TotalPaxName"]
        totalPax <- map["TotalPax"]
        extraDesc <- map["ExtraDesc"]
        transferDesc <- map["TransferDesc"]
        transferTotalPax <- map["TransferTotalPax"]
        transferTotalAmount <- map["TransferTotalAmount"]
        couponNumber <- map["CouponNumber"]
    }
}
