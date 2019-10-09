//
//  ViewController.swift
//  ExCombine
//
//  Created by Jery on 9/27/19.
//  Copyright © 2019 Jery. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    let subject = PassthroughSubject<Int, Never>()
    var cancels = [AnyCancellable]()
    let viewModel = RoomListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configs()
        self.viewModel.loadRooms()
    }
    
    private func configs() {
        self.navigationItem.title = "Chat App"
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.loadingView.startAnimating()
    
        self.configBinding()
    }
    
    private func configBinding() {
        let sub = self.viewModel.$onRoomChange
            .receive(on: DispatchQueue.main)
            .throttle(for: .milliseconds(500), scheduler: RunLoop.main, latest: true)
            .sink { [weak self] (changed) in
                print("received: \(changed)")
                if changed {
                    self?.collectionView.reloadData()
                    self?.loadingView.stopAnimating()
                    self?.loadingView.isHidden = true
                }
            }
        self.cancels.append(sub)
    }
}

//
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rooms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RoomViewCell.self), for: indexPath) as! RoomViewCell
        cell.room = self.viewModel.rooms[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 83)
    }

}
