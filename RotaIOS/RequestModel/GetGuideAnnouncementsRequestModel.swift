//
//  GetGuideAnnouncementsAndDocumentsRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.07.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetGuideAnnouncementsRequestModel : Mappable{
    
    public var id = 0
    public var GuideId : Int!
    public var GuideAreaId = 0
    public var GuideMarketId = 0
    public var MainType = 368
    
    public required init?(map: Map) {
        
    }
    
    public init( GuideId : Int, MainType : Int ) {
        self.GuideId = GuideId
        self.MainType = MainType
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "/?id=\(self.id)&GuideId=\(self.GuideId ?? 310)&GuideAreaId=\(self.GuideAreaId)&GuideMarketId=\(self.GuideMarketId)&MainType=\(self.MainType)"
    }
}
