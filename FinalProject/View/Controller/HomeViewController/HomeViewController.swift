//
//  HomeViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 9/23/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.homeTitle
        navigationController?.navigationBar.backgroundColor = .red

        let catagoryButton = UIBarButtonItem(title: App.String.catelogyStr, style: .plain, target: self, action: #selector(buttonDidClick))
        catagoryButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = catagoryButton
    }

    @objc func buttonDidClick() {
    }

}
