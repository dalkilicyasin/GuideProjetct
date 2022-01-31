//
//  Defaults.swift
//  BaseProject
//
//  Created by Bekir's Mac on 7.03.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//

import Foundation
import ObjectMapper

public var userDefaultsData:Defaults = Defaults()

public class Defaults{
    public enum DefaultsType {
        case UserName
        case LanguageID
        case DeviceID
        case UserID
        case GuideID
        case SaleDate
        case MarketId
        case HotelId
        case HotelArea
        case MarketGruopId
        case Favorite
        case SearchTourOfflineData
        case Password
        case TourList
        case PaxesList
        case ExtrasList
        case TransferList
        case ManuelandHousePaxesList
        case TotalPrice
        case SaveDay
        case TouristDetailInfoList
        case Data
        case MaxVoucher
        case TourSalePost
        case PromotionId
        case CurrencyList
        case ExchangeRates
        case OfflineHotelId
        case OfflineMarketId
    }
    
   public init(){}
    public func saveDay(day:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .SaveDay)
        preferences.set(day, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getDay() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .SaveDay)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    // CurrencyList
    func saveCurrencyList(tour:[GetCurrencyResponeModel]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .CurrencyList))
            preferences.synchronize()
        }
    }
    
    func getCurrencyList() -> [GetCurrencyResponeModel]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .CurrencyList)) as? Data {
            if let loadedTourList = try? decoder.decode([GetCurrencyResponeModel].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    // ExchangeRates
    func saveExchangeRates(tour:[GetExhangeRatesResponseModel]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .ExchangeRates))
            preferences.synchronize()
        }
    }
    
    func getExchangeRates() -> [GetExhangeRatesResponseModel]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .ExchangeRates)) as? Data {
            if let loadedTourList = try? decoder.decode([GetExhangeRatesResponseModel].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    // TourSaleSave
    func saveTourSalePost(tour:[TourSalePost]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .TourSalePost))
            preferences.synchronize()
        }
    }
    
    func getTourSalePost() -> [TourSalePost]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .TourSalePost)) as? Data {
            if let loadedTourList = try? decoder.decode([TourSalePost].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    //SaveData
    public func saveData(id:[String]){
        let preferences = UserDefaults.standard
        preferences.set( id , forKey:getIdentifier(type: .Data))
        preferences.synchronize()
    }
    
    public func getData() -> [String]! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Data)) == nil {
            return nil
        }
        let data: [String] = preferences.value(forKey: getIdentifier(type: .Data)) as! [String]
        return data
    }
    
    //TouristDetailInfoList
    
    func saveTouristDetailInfoList(tour:[Paxes]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .TouristDetailInfoList))
            preferences.synchronize()
        }
    }
    
    func getTouristDetailInfoList() -> [Paxes]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .TouristDetailInfoList)) as? Data {
            if let loadedTourList = try? decoder.decode([Paxes].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    //VoucherNodatecheck
    
    public func saveMaxVoucher(voucher:[String]){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .MaxVoucher)
        preferences.set(voucher, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getMaxVoucher() -> [String]! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .MaxVoucher)) == nil {
            return nil
        }
        let data:[String] = preferences.value(forKey: getIdentifier(type: .MaxVoucher)) as! [String]
        return data
    }
    
    // Save Total Price
    public func saveExtrasandTransfersTotalPrice(totalPrice: Double){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .TotalPrice)
        preferences.set(totalPrice, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getExtrasandTransfersTotalPrice() -> Double{
        let preferences = UserDefaults.standard
        let totalPrice = getIdentifier(type: .TotalPrice)
        if preferences.object(forKey: totalPrice) == nil {
            return -1
        } else {
            return preferences.double(forKey: totalPrice)
        }
    }
    
    // UserName and Password
    public func saveUserName(id:String){
        let preferences = UserDefaults.standard
        preferences.set( id , forKey:getIdentifier(type: .UserName))
        preferences.synchronize()
    }
    
    public func geUserNAme() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .UserName)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .UserName)) as! String
        return data
    }
    
    public func savePassword(id:String){
        let preferences = UserDefaults.standard
        preferences.set( id , forKey:getIdentifier(type: .Password))
        preferences.synchronize()
    }
    
    public func getPassword() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Password)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .UserName)) as! String
        return data
    }
    
    
    //SearchTourOfflineData
    
    func saveSearchTourOffline(tour:[GetSearchTourResponseModel]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .SearchTourOfflineData))
            preferences.synchronize()
        }
    }
    
    func getSearchTourOffline() -> [GetSearchTourResponseModel]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .SearchTourOfflineData)) as? Data {
            if let loadedTourList = try? decoder.decode([GetSearchTourResponseModel].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    // Save ManuelandHousePaxesList
    func saveManuelandHousePaxesList(tour:[Paxes]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .ManuelandHousePaxesList))
            preferences.synchronize()
        }
    }
    
    func getManuelandHousePaxesList() -> [Paxes]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .ManuelandHousePaxesList)) as? Data {
            if let loadedTourList = try? decoder.decode([Paxes].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    //Tour and Paxes List saving
    //Tour
    func saveTourList(tour:[GetSearchTourResponseModel]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .TourList))
            preferences.synchronize()
        }
    }
    
    func getTourList() -> [GetSearchTourResponseModel]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .TourList)) as? Data {
            if let loadedTourList = try? decoder.decode([GetSearchTourResponseModel].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    //Paxes
    
    func savePaxesList(tour:[GetInHoseListResponseModel]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .PaxesList))
            preferences.synchronize()
        }
    }
    
    func getPaxesList() -> [GetInHoseListResponseModel]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .PaxesList)) as? Data {
            if let loadedTourList = try? decoder.decode([GetInHoseListResponseModel].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    
    //Extras and Transfer List saving
    //Extras
    func saveExtrasList(tour:[Extras]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .ExtrasList))
            preferences.synchronize()
        }
    }
    
    func getExtrasList() -> [Extras]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .ExtrasList)) as? Data {
            if let loadedTourList = try? decoder.decode([Extras].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    //Transfers
    
    func saveTransfersList(tour:[Transfers]){
        let preferences = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tour){
            preferences.set(encoded, forKey: getIdentifier(type: .TransferList))
            preferences.synchronize()
        }
    }
    
    func getTransfersList() -> [Transfers]? {
        let preferences = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedTourList = preferences.object(forKey: getIdentifier(type: .TransferList)) as? Data {
            if let loadedTourList = try? decoder.decode([Transfers].self, from: savedTourList){
                return loadedTourList
            }
        }
        return []
    }
    
    //LanguageID
    public func saveLanguageId(languageId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .LanguageID)
        preferences.set(languageId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getLanguageId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .LanguageID)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    // DeviceID
    public func saveDeviceId(id:String){
        let preferences = UserDefaults.standard
        preferences.set( id , forKey:getIdentifier(type: .DeviceID))
        preferences.synchronize()
    }
    
    public func getDeviceId() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .DeviceID)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .DeviceID)) as! String
        return data
    }
    
    public func saveUserId(languageId:String){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .UserID)
        preferences.set(languageId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getUserId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .UserID)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    public func saveGuideId(languageId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .GuideID)
        preferences.set(languageId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getGuideId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .GuideID)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    // SaveFavoriteDefaults
    
    public func saveFavorite(id:[String]){
        let preferences = UserDefaults.standard
        preferences.set( id , forKey:getIdentifier(type: .Favorite))
        preferences.synchronize()
    }
    
    public func getFavorite() -> [String]! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Favorite)) == nil {
            return nil
        }
        let data: [String] = preferences.value(forKey: getIdentifier(type: .Favorite)) as! [String]
        return data
    }
 
    

    
    // MarketGruopId
    
    public func saveMarketGruopId(marketGroupId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .MarketGruopId)
        preferences.set(marketGroupId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getMarketGruopId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .MarketGruopId)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    // SaleDAte
    
    public func saveSaleDate(saleDate:String){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .SaleDate)
        preferences.set(saleDate, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getSaleDate() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .SaleDate)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .SaleDate)) as! String
        return data
    }
    

    // MarketID( value değeri olan)
    
    public func saveMarketId(marketId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .MarketId)
        preferences.set(marketId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getMarketId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .MarketId)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
        
    // PromotionIdSave
    public func savePromotionId(promotionId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .PromotionId)
        preferences.set(promotionId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getPromotionId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .PromotionId)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    
    // MarketID( value değeri olan)
    
    public func saveOfflineMarketId(marketId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .OfflineMarketId)
        preferences.set(marketId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getOfflineMarketId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .OfflineMarketId)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    //offlinehotelID
    public func saveOfflineHotelId(hotelId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .OfflineHotelId)
        preferences.set(hotelId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getOfflineHotelId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .OfflineHotelId)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    // HotelID(value değeri olan)
    public func saveHotelId(hotelId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .HotelId)
        preferences.set(hotelId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getHotelId() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .HotelId)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }

    
    public func saveHotelArea(hotelAreaId:Int){
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .HotelArea)
        preferences.set(hotelAreaId, forKey: currentLanguageKey)
        preferences.synchronize()
    }
    
    public func getHotelArea() -> Int{
        let preferences = UserDefaults.standard
        let currentLanguageKey = getIdentifier(type: .HotelArea)
        if preferences.object(forKey: currentLanguageKey) == nil {
            return -1
        } else {
            return preferences.integer(forKey: currentLanguageKey)
        }
    }
    
    
    private  func  getIdentifier(type:DefaultsType)->String {
        switch type {
        case .LanguageID:
            return "LanguageID"
        case .DeviceID:
            return "DeviceID"
        case .UserID:
            return "DeviceID"
        case .GuideID:
            return "GuideID"
        case .SaleDate:
            return "SaleDate"
        case .MarketId:
            return "MarketId"
        case .HotelId:
            return "HotelId"
        case .HotelArea:
            return "HotelArea"
        case .MarketGruopId:
            return "MarketGruopId"
        case .Favorite:
            return "Favorite"
        case .UserName:
            return "UserName"
        case .SearchTourOfflineData:
            return "SearchTourOfflineData"
        case .Password:
            return "Password"
        case .TourList:
            return "TourList"
        case .PaxesList:
            return "PaxesList"
        case .ExtrasList:
            return "ExtrasList"
        case .TransferList:
            return "TransferList"
        case .ManuelandHousePaxesList:
            return "ManuelandHousePaxesList"
        case .TotalPrice:
            return "TotalPrice"
        case .SaveDay:
            return "SaveDay"
        case .TouristDetailInfoList:
            return "TouristDetailInfoList"
        case .Data:
            return "Data"
        case .MaxVoucher:
            return "MaxVoucher"
        case .TourSalePost:
            return "TourSalePost"
        case .PromotionId:
            return "PromotionId"
        case .CurrencyList:
           return "CurrencyList"
        case .ExchangeRates:
            return "ExchangeRates"
        case .OfflineHotelId:
            return "OfflineHotelId"
        case .OfflineMarketId:
            return "OfflineMarketId"
        }
    }
}
