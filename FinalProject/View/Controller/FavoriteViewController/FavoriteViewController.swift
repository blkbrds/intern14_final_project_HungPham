//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = "FAVORITE"
        navigationController?.navigationBar.backgroundColor = .red
    }
}
