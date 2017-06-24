//
//  CommunityGardens.swift
//  GetGreen
//
//  Created by Annie Tung on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import Foundation

class CommunityGardens {
    var boro: String
    var name: String
    var address: String
    var neighborhood: String
    
    init(boro: String, name: String, address: String, neighborhood: String) {
        self.boro = boro
        self.name = name
        self.address = address
        self.neighborhood = neighborhood
    }
    
    static func parseArray(from arrOfDict: [[String:Any]]) -> [CommunityGardens]? {
        var arrOfGardens = [CommunityGardens]()
        for jsonDict in arrOfDict {
            if let gardenObj = CommunityGardens.parseDict(from: jsonDict) {
                arrOfGardens.append(gardenObj)
            }
        }
        return arrOfGardens
    }
    
    static func parseDict(from dict: [String:Any]) -> CommunityGardens? {
        
        guard
            let boro = dict["boro"] as? String,
            let name = dict["garden_name"] as? String,
            let address = dict["address"] as? String,
            let neighborhood = dict["neighborhoodname"] as? String else { return nil }
        let gardenObject = CommunityGardens(boro: boro, name: name, address: address, neighborhood: neighborhood)
        return gardenObject
    }
}
