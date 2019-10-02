//
//  VideoViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 10/1/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//
import YoutubePlayer_in_WKWebView
import UIKit

class VideoViewController: UIViewController {

    var videoID: String = ""

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var playerView: WKYTPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.playVideo
        navigationController?.navigationBar.backgroundColor = .red

        closeButton.layer.cornerRadius = 20
        playerView.load(withVideoId: videoID)
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
