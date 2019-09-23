//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 9/23/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.favoriteTitle
        navigationController?.navigationBar.backgroundColor = .red
    }

}
