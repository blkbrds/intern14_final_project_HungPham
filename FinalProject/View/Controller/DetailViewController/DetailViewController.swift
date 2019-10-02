//
//  DetailViewController.swift
//  FinalProject
//
//  Created by PCI0010 on 10/1/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//
import YoutubePlayer_in_WKWebView
import UIKit

final class DetailViewController: UIViewController {

    var viewModel = DetailViewModel()

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var playerView: UIView!
    @IBOutlet private weak var videoImage: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var viewCountLabel: UILabel!
    @IBOutlet private weak var publicDateLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var dislikeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var authorImage: UIImageView!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var authorText: UILabel!
    @IBOutlet private weak var authorImageView2: UIImageView!
    @IBOutlet private weak var authorImageView3: UIImageView!
    @IBOutlet private weak var authorName2: UILabel!
    @IBOutlet private weak var authorText2: UILabel!
    @IBOutlet private weak var authorName3: UILabel!
    @IBOutlet private weak var authorText3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configUI()
        configThumbnail()
    }

    @IBAction func playButton(_ sender: UIButton) {
        let vc = VideoViewController()
        vc.videoID = viewModel.id
        present(vc, animated: true, completion: nil)
    }

    func configData() {
        viewModel.getDataComment { [weak self] (done) in
            guard let this = self else { return }
            if done {
                if this.viewModel.myComment.isNotEmpty {
                    this.authorName.text = this.viewModel.myComment[0].authorDisplayName
                    this.authorText.text = this.viewModel.myComment[0].textOriginal
                    this.authorImage.sd_setImage(with: URL(string: this.viewModel.myComment[0].authorProfileImageUrl))

                    this.authorName2.text = this.viewModel.myComment[1].authorDisplayName
                    this.authorText2.text = this.viewModel.myComment[1].textOriginal
                    this.authorImageView2.sd_setImage(with: URL(string: this.viewModel.myComment[1].authorProfileImageUrl))

                    this.authorName3.text = this.viewModel.myComment[2].authorDisplayName
                    this.authorText3.text = this.viewModel.myComment[2].textOriginal
                    this.authorImageView3.sd_setImage(with: URL(string: this.viewModel.myComment[2].authorProfileImageUrl))
                }
            } else {
                print("Can't Load Data!")
            }
        }
    }

    func configUI() {
        title = App.String.detailTitle
        navigationController?.navigationBar.backgroundColor = .red

        tableView.register(UINib(nibName: "DetailInfoCell", bundle: nil), forCellReuseIdentifier: "cell4")

        let catagoryButton = UIBarButtonItem(image: UIImage(named: "ic-heart"), style: .plain, target: self, action: #selector(buttonDidClick))
        catagoryButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = catagoryButton

        authorImage.layer.cornerRadius = 20
        authorImageView2.layer.cornerRadius = 20
        authorImageView3.layer.cornerRadius = 20
    }

    @objc func buttonDidClick() {
        print("Liked Video !")
    }

    func configThumbnail() {
        videoImage.sd_setImage(with: URL(string: viewModel.imageURL))
        timeLabel.text = viewModel.duration.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with: ":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        titleLabel.text = viewModel.title
        viewCountLabel.text = viewModel.viewCount + " views"
        likeLabel.text = viewModel.likeCount + " Like"
        dislikeLabel.text = viewModel.dislikeCount + " Dislike"
        publicDateLabel.text = viewModel.publishedAt
        descriptionLabel.text = viewModel.descriptionDetail
    }
}
