//
//  RoomListViewModel.swift
//  ExCombine
//
//  Created by Jery on 9/27/19.
//  Copyright © 2019 Jery. All rights reserved.
//

import UIKit
import Combine

class RoomListViewModel {
    private var roomListRepo = RoomListRepo()
    private var subscriptions = [AnyCancellable]()
    
    var rooms = [RoomInfo]()
    @Published var onRoomChange: Bool = false
    
    func loadRooms() {
        let sub = self.roomListRepo.loadRoom().eraseToAnyPublisher()
            .receive(on: DispatchQueue.global(qos: .background))
            .flatMap({ (rooms) -> Publishers.Sequence<[RoomInfo], Never> in
//                print("flatmap: \(Thread.isMainThread)")
                self.rooms = rooms
                self.onRoomChange = true
                return rooms.publisher
            })
            .flatMap({ (room) -> AnyPublisher<RoomInfo, Never> in
//                print("received: \(room.id)")
                print(Thread.current)
                return self.roomListRepo.loadUnreadCount(room: room).eraseToAnyPublisher()
            }).sink { vl in
                for r in self.rooms {
                    if r.id == vl.id {
                        r.unreadCount = vl.unreadCount
                        self.onRoomChange = true
                        break
                    }
                }
            }
        self.subscriptions.append(sub)
    }
}
