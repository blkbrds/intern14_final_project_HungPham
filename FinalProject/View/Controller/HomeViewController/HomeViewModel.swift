//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by PCI0010 on 9/24/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class HomeViewModel {

    var myTrendings: [Trending] = []

    // Mark : - Load Data From API
    func loadData(completion: @escaping (Bool) -> ()) {
        ApiManager.Snippet.getTrendingData() { (result) in
            switch result {
            case .success(let trendingResult):
                self.myTrendings.append(contentsOf: trendingResult.myTrending)
                self.saveData(objects: self.myTrendings)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    func saveData(objects: [Trending]) {
        for item in objects {
            myTrendings.append(item)
        }
    }

    func downloadImage(indexPath: IndexPath, completion: @escaping (UIImage?, IndexPath) -> ()) {
        let item = myTrendings[indexPath.row]
        ApiManager.Downloader.downloadImage(imageURL: item.imageURL, index: indexPath.row) { (image, index) in
            if let image = image {
                item.videoImage = image
                completion(image, indexPath)
            } else {
                completion(nil, indexPath)
            }
        }
    }
}

extension HomeViewModel {
    func numberOfItems(in section: Int) -> Int {
        return myTrendings.count
    }
    
    func getMusic(with indexPath: IndexPath) -> Trending {
        return myTrendings[indexPath.row]
    }
}
