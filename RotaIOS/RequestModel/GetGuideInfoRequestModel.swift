//
//  GetGuideInfoRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 20.05.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetGuideInfoRequestModel : Mappable{
    
    public var id : Int!
    
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
