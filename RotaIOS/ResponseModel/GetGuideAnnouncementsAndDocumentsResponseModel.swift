//
//  GetGuideAnnouncementsAndDocumentsResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.07.2021.
//

import Foundation
import ObjectMapper

struct GetGuideAnnouncementsAndDocumentsResponseModel : Mappable {
    
    var id : String?
    var record : [Record]?
    var isSuccesful : Bool?
    var resultKey : String?
    var message : String?
    var detailMessage : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        record <- map["Record"]
        isSuccesful <- map["IsSuccesful"]
        resultKey <- map["ResultKey"]
        message <- map["Message"]
        detailMessage <- map["DetailMessage"]
    }
}

struct Record : Mappable {
    var opened = false
    var id : String?
   // var id : Int?
    var mainTypeId : Int?
    var mainType : String?
    var header : String?
    var description : String?
    var fileUrl : String?
    var sender : String?
    var sentDateTime : String?

    init?(map: Map) {

    }
    /*
    public init( opened : Bool, header : String, description : String, fileUrl : String, sender : String, sentDateTime : String ) {
        self.opened = opened
        self.header = header
        self.description = description
        self.fileUrl = fileUrl
        self.sender = sender
        self.sentDateTime = sentDateTime
    }*/

    mutating func mapping(map: Map) {

        id <- map["id"]
       // id <- map["Id"]
        mainTypeId <- map["MainTypeId"]
        mainType <- map["MainType"]
        header <- map["Header"]
        description <- map["Description"]
        fileUrl <- map["FileUrl"]
        sender <- map["Sender"]
        sentDateTime <- map["SentDateTime"]
    }
}
