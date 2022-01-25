//
//  GetInHouseListTourSaleRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 25.01.2022.
//

//
//  GetInHouseListRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 11.05.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetInHouseListTourSaleRequestModel : Mappable{
    
    public var hotelId : String!
    public var saleDate : String!
    public var tourId : String!
    public var vouchers = ""
    public var market : String!

    
    public required init?(map: Map) {
        
    }
    
    public init(hotelId:String, saleDate:String, tourId : String, market : String) {
        self.hotelId = hotelId
        self.saleDate = saleDate
        self.tourId = tourId
        self.market = market
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?hotelId=\(self.hotelId ?? "")&saleDate=\(self.saleDate ?? "")&tourId=\(self.tourId ?? "")&market=\(self.market ?? "")&vouchers=\(self.vouchers)"
    }
}

