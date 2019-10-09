//
//  RoomListRepo.swift
//  ExCombine
//
//  Created by Jery on 9/27/19.
//  Copyright © 2019 Jery. All rights reserved.
//

import UIKit
import Combine

class RoomListRepo: RoomList {
    func loadRoom() -> Future<[RoomInfo], Never> {
        return Future { delegate in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                delegate(.success(self.generateRooms()))
            }
        }
    }
    
    func loadUnreadCount(room: RoomInfo) -> Future<RoomInfo, Never> {
        return Future {completion in
            let r = Double.random(in: 1...8)
            DispatchQueue.global().asyncAfter(deadline: .now() + r) {
                room.unreadCount = Int.random(in: 1...9)
                completion(.success(room))
            }
            
        }
    }
}

extension RoomListRepo {
    private func generateRooms() -> [RoomInfo] {
        var rs = [RoomInfo]()
        for i in 0..<20 {
            rs.append(RoomInfo(id: i, name: "My Buddy #\(i + 1)", lastMsg: "How are you today?"))
        }
        return rs
    }
}

protocol RoomList {
    func loadRoom() -> Future<[RoomInfo], Never>
    func loadUnreadCount(room: RoomInfo) -> Future<RoomInfo, Never>
}
