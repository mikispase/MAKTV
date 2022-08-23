//
//  TVViewController+Extension.swift
//  MakTV
//
//  Created by Dimitar Spasovski on 22.8.22.
//  Copyright © 2022 Dimitar Spasovski. All rights reserved.
//

import Foundation
import AVKit
import SwiftyJSON

@objc extension TVViewController {
    
    @objc func televisionName() -> NSArray {
        let televisionNames:[String] = self.televisionDictionary.compactMap({ ($0 as! TVObject).imageName})
        return televisionNames as NSArray
    }
    
    @objc func televisionUrlStrings() -> NSArray {
        let televisionNames:[String] = self.televisionDictionary.compactMap({ ($0 as! TVObject).url.absoluteString})
        return televisionNames as NSArray
    }
    
    @objc func presentPplayer(indexPath:NSIndexPath) {
        controller = AVPlayerViewController()

        let model = self.televisionDictionary[indexPath.row] as! TVObject
        self.currentTVObject = model
        controller.player = AVPlayer(url:model.url)
        controller.player?.play()

        var actionsList:[UIAction] = []
        for info in model.infoArray {
            let resolution = info.resolution.components(separatedBy: "x")
            let favoriteActions = UIAction(title: resolution.first!.appending("p").replacingOccurrences(of: "1", with: "0")) { action in
                debugPrint(action.title)
                self.changeResultion(title: action.title)
            }
            actionsList.append(favoriteActions)
        }
        
          if #available(tvOS 15.0, *) {
              let submenu = UIMenu(title: "Resolutions", options: [ .displayInline ], children: actionsList )
              let menu = UIMenu(image: UIImage(systemName: "gearshape"), children: [submenu])
              controller.transportBarCustomMenuItems = [menu]
              controller.isSkipForwardEnabled = false
              controller.isSkipBackwardEnabled = false
              controller.requiresLinearPlayback = false
              controller.playbackControlsIncludeInfoViews = false
//              controller.playbackControlsIncludeTransportBar = true
           //   controller.transportBarIncludesTitleView = true
          }
          self.present(controller, animated: true);
    }
    
    func changeResultion(title:String) {
        var withoutP = title.replacingOccurrences(of: "p", with: "")
        var info = (self.currentTVObject as! TVObject).infoArray.first(where: { $0.resolution.contains(withoutP)  })
        if info == nil {
            withoutP = withoutP.replacingOccurrences(of: "0", with: "1")
            info = (self.currentTVObject as! TVObject).infoArray.first(where: { $0.resolution.contains(withoutP) })
        }
        debugPrint(info?.URI)
        
        let url =  info?.baseURL?.appendingPathComponent(info!.URI)
        controller.player = AVPlayer(url: url!)
        controller.player?.play()
    }
    
}
