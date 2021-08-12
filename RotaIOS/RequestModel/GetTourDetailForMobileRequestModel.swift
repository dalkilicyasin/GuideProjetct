//
//  GetTourDetailForMobileRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 9.08.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetTourDetailForMobileRequestModel : Mappable{
    
    public var guideId : Int!
    public var begindate : String!
    public var endDate : String!
    public var saleDate : String!
    public var voucher : String!
    public var tourId : String!
    public var statusId : String!
    public var saleEndDate : String!
    
    
    public required init?(map: Map) {
        
    }
    
    public init( begindate : String, guideId : Int, endDate : String, saleDate : String, voucher : String, tourId : String, statusId : String, saleEndDate : String ) {
        self.begindate = begindate
        self.guideId = guideId
        self.endDate = endDate
        self.saleDate = saleDate
        self.voucher = voucher
        self.tourId = tourId
        self.statusId = statusId
        self.saleEndDate = saleEndDate
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideId=\(self.guideId ?? 0)&begindate=\(self.begindate ?? "")&endDate=\(self.endDate ?? "")&saleDate=\(self.saleDate ?? "")&voucher=\(self.voucher ?? "")&tourId=\(self.tourId ?? "")&statusId=\(self.statusId ?? "")&saleEndDate=\(self.saleEndDate ?? "")"
    }
}
