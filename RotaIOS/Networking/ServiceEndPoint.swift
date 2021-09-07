//
//  ServiceEndPoint.swift
//  BaseProject
//
//  Created by Cüneyt AYVAZ on 2.07.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//

import Foundation

public enum ServiceEndPoint: String {
    case CreateToken = "/api/api/User/GetToken"
    case GetUser = "/api/api/User/GetMyInfo"
    case GetGuideMarkets = "/api/api/IndShop/GetGuideMarkets"
    case GetHotelsMobie = "/api/api/TourSale/GetHotelsMobile"
    case GetInHouseList = "/api/api/IndShop/GetInHouseList"
    case GetTouristInfo = "/api/api/IndShop/GetTouristInfo"
    case GetSelectList = "/api/api/Company/GetSelectList"
    case GetSaveForMobile = "/api/api/IndShop/SaveForMobile"
    case GetGuideInfo =  "/api/api/IndShop/GetGuideInfo"
    case GetGuideAnnoucemenstAndDocuments = "/api//api/Announcement/GetGuideAnnouncementsAndDocuments"
    case TourGetSelectList = "/api/api/TourDefinition/GetSelectList"
    case TourGetTourDetailForMobile = "/api/api/TourSale/GetTourDetailForMobile"
    case GetIndShopDetailForMobile = "/api/api/IndShop/GetIndShopDetailForMobile"
    case GetVoucherDetail = "/api/api/TourSale/GetVoucherDetail"
    case GetMobilCancelRules = "/api/api/TourSaleCancel/GetMobileCancelRules"
    case GetPaymentTypes = "/api/api/TourSale/GetPaymentTypes"
    case GetCalculateCancelFee = "/api/api/TourSaleCancel/CalculateCancelFee"
}


