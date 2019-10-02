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
        viewModel.getDataComment { done in
            if done {
                self.tableView.reloadData()
            } else {
                print("Can't Load Data!")
            }
        }
    }

    func configUI() {
        title = App.String.detailTitle
        navigationController?.navigationBar.backgroundColor = .red

        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell5")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-heart"), style: .plain, target: self, action: #selector(buttonDidClick))
        favoriteButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc func buttonDidClick() {
        print("Liked Video !")
    }

    func configThumbnail() {
        videoImage.sd_setImage(with: URL(string: viewModel.imageURL))
        timeLabel.text = viewModel.duration.replacingOccurrences(of: "PT", with: "")
            .replacingOccurrences(of: "H", with: ":")
            .replacingOccurrences(of: "M", with: ":")
            .replacingOccurrences(of: "S", with: "")
        titleLabel.text = viewModel.title
        viewCountLabel.text = viewModel.viewCount + " views"
        likeLabel.text = viewModel.likeCount + " Like"
        dislikeLabel.text = viewModel.dislikeCount + " Dislike"
        publicDateLabel.text = viewModel.publishedAt
        descriptionLabel.text = viewModel.descriptionDetail
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsTrending(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as? CommentCell else { return UITableViewCell() }
        let myComments = viewModel.getComment(with: indexPath)
        let cellViewModel = CommentCellModel(myVideo: myComments)
        cell.viewModel = cellViewModel
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments :"
    }
}
