//
//  TVObject.swift
//  MakTV
//
//  Created by Dimitar Spasovski on 22.8.22.
//  Copyright © 2022 Dimitar Spasovski. All rights reserved.
//

import Foundation

@objc class TVObject :NSObject {
    @objc var imageName:String
    @objc var url:URL
    @objc var model:M3U8PlaylistModel?
    @objc var videoArray:[NSDictionary] = []
    @objc var infoArray:[Info] = []

    @objc init(imageName:String, url:URL) {
        self.imageName = imageName
        self.url = url
        
        self.model = try? M3U8PlaylistModel(url: self.url)
        
        guard let model = model else {
            return
        }
        
        for i in 0..<model.masterPlaylist.xStreamList.count {
            let dictionary = self.model!.masterPlaylist.xStreamList.xStreamInf(at: i).dictionary!
            videoArray.append(NSDictionary(dictionary: dictionary))
        }
        self.infoArray = []
        for obj in videoArray {
            let info = Info(dictionary: obj)
            self.infoArray.append(info)
        }
        
    }
}
