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
    case GetIndShopDetailForMobile = "/api/api/IndShop/GetIndShopDetailForMobile2"
    case GetVoucherDetail = "/api/api/TourSale/GetVoucherDetail"
    case GetMobilCancelRules = "/api/api/TourSaleCancel/GetMobileCancelRules"
    case GetPaymentTypes = "/api/api/TourSale/GetPaymentTypes"
    case GetCalculateCancelFee = "/api/api/TourSaleCancel/CalculateCancelFee"
    case GetTourSaleCancelMobile = "/api/api/TourSaleCancel/CancelMobile"
    case GetHotelSelectListByAreaRef = "/api/api/Hotel/GetHotelSelectListByAreaRef"
    case GetGuideSelectList = "/api/api/Guide/GetSelectList"
    case GetSpeakTimeForMobile = "/api/api/GSpeakTime/GetSpeakTimeForMobile"
    case GetSearchZReport = "/api/api/AccountingZReportMobile/SearchZReport"
    case GetZReportData = "/api/api/AccountingZReportMobile/GetReportData"
    case GetZReportPayments = "/api/api/AccountingZReportMobile/GetReportPayments"
    case GetZReportRefunds = "/api/api/AccountingZReportMobile/GetReportRefunds"
    case GetGuideDailyReport = "/api/api/AccountingZReportMobile/GetGuideDailyReport"
    case GetZReportPreview = "/api/api/AccountingZReportMobile/GetReportPreview"
    case GetCreateZReportPreview = "/api/api/AccountingZReportMobile/CreateZReport"
    case GetTourSaleSearchTour = "/api/api/TourSale/SearchTour"
    case GetTourSearchCache = "/api/api/TourSale/GetTourSearchCache"
    case GetCurrencySelectList = "/api/api/Currency/GetSelectList"
    case GetExhangeRates = "/api/api/Exchange/GetExhangeRates"
    case GetMaxGuideVoucherNumber = "/api/api/TourSale/GetMaxGuideVoucherNumber"
    case GetSaveMobileSale = "/api/api/TourSale/SaveMobileSale"
}


