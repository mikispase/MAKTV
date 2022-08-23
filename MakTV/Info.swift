//
//  Info.swift
//  MakTV
//
//  Created by Dimitar Spasovski on 22.8.22.
//  Copyright © 2022 Dimitar Spasovski. All rights reserved.
//

import Foundation


@objc class Info :NSObject {
    @objc var resolution:String = ""
    @objc var URI:String = ""
    @objc var BANDWIDTH:String = ""
    @objc var baseURL:URL? = nil


    convenience init(resolution:String,URI:String,BANDWIDTH:String, baseURL:URL ) {
        self.init()
        self.resolution = resolution
        self.URI = URI
        self.BANDWIDTH = BANDWIDTH
        self.baseURL = baseURL
    }

    convenience init(dictionary:NSDictionary) {
        self.init()
        let resolution = dictionary.value(forKey: "RESOLUTION")
        let URI = dictionary.value(forKey: "URI")
        let BANDWIDTH = dictionary.value(forKey: "BANDWIDTH")
        let baseURL = dictionary.value(forKey: "baseURL")
        
        self.resolution = resolution as! String
        self.URI = URI as! String
        self.BANDWIDTH = BANDWIDTH as! String
        self.baseURL = baseURL as! URL
    }
    

    
//    let resolution = obj.value(forKey: "RESOLUTION")
//    let URI = obj.value(forKey: "URI")
//    let BANDWIDTH = obj.value(forKey: "BANDWIDTH")
//    let baseURL = obj.value(forKey: "baseURL")
//    let PROGRAMID =  obj.value(forKey: "PROGRAM-ID")
    
}

