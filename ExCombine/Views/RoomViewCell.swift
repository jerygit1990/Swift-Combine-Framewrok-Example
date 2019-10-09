//
//  RoomViewCell.swift
//  ExCombine
//
//  Created by Jery on 10/9/19.
//  Copyright © 2019 Jery. All rights reserved.
//

import UIKit

class RoomViewCell: UICollectionViewCell {
    @IBOutlet weak var txtName: UILabel!
    
    @IBOutlet weak var txtLastMsg: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var txtUnreadCount: UILabel!
    
    var room: RoomInfo? {
        didSet {
            if let r = self.room {
                txtName.text = r.name
                txtUnreadCount.text = String(r.unreadCount)
                
                if r.unreadLoaded {
                    self.txtUnreadCount.isHidden = false
                    self.loading.isHidden = true
                    self.loading.stopAnimating()
                } else {
                    self.txtUnreadCount.isHidden = true
                    self.loading.isHidden = false
                    self.loading.startAnimating()
                }
            }
        }
    }
}
