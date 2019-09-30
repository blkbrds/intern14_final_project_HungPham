//
//  SearchViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = "SEARCH"
        navigationController?.navigationBar.backgroundColor = .red
    }
}
