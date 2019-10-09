//
//  RoomInfo.swift
//  ExCombine
//
//  Created by Jery on 9/27/19.
//  Copyright © 2019 Jery. All rights reserved.
//

import UIKit

class RoomInfo {
    var id: Int
    var name: String
    var lastMsg: String
    var unreadCount: Int
    
    var unreadLoaded: Bool {
        return unreadCount >= 0
    }

    init(id: Int, name: String, lastMsg: String, unreadCount: Int = -1) {
        self.id = id
        self.name = name
        self.lastMsg = lastMsg
        self.unreadCount = unreadCount
    }
}
