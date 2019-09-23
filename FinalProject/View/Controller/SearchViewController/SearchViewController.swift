//
//  SearchViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 9/23/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.searchTitle
        navigationController?.navigationBar.backgroundColor = .red
    }

}
