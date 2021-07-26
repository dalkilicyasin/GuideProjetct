//
//  GetGuideAnnouncementsAndDocumentsRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.07.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetGuideAnnouncementsAndDocumentsRequestModel : Mappable{
    
    public var id = 0
    public var GuideId : Int!
    public var GuideAreaId : Int!
    public var GuideMarketId : Int!
    public var MainType : Int!
    
    
    
    public required init?(map: Map) {
        
    }
    
    public init( id : Int ) {
        self.id = id
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "/?id=\(self.id ?? 0)"
    }
    
}
