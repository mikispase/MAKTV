//
//  TelevisionViewController+Extension.swift
//  MakTV
//
//  Created by Dimitar Spasovski on 16.8.22.
//  Copyright © 2022 Dimitar Spasovski. All rights reserved.
//

import Foundation
import AVKit
import SwiftyJSON

@objc extension TelevisionViewController {
    
    @objc  func presentPplayer() {
         controller = AVPlayerViewController()
          
//          var urlString = ""
//          var counter = 0
//          for (_,value) in self.televisionDictionary.enumerated() {
//              urlString = value.value as! String
//              if counter == indexPath.row {
//                  break
//              }
//              counter+=1
//          }
//
          
        if let url = URL(string: self.televisionUrlString ) {
              controller.player = AVPlayer(url:url)
              controller.player?.play()

          }
          
          if #available(tvOS 15.0, *) {
              let favoriteActions = UIAction(title: "Favorites", image: UIImage(systemName: "heart")) { action in }
              let submenu = UIMenu(title: "Speed", options: [ .displayInline,.singleSelection ], children: [ favoriteActions,favoriteActions,favoriteActions,favoriteActions ])
              
              let menu = UIMenu(image: UIImage(systemName: "gearshape"), children: [submenu])
              controller.transportBarCustomMenuItems = [menu]
              controller.playbackControlsIncludeInfoViews = true

          }
          
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.pushViewController(self.controller!, animated: true)

        }
    }
    
}



