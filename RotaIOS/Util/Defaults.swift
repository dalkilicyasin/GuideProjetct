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
    }
    
   public init(){}
    
    
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
        }
    }
}
