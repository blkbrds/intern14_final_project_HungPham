import YoutubePlayer_in_WKWebView
import UIKit
import Realm
import RealmSwift

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
    @IBOutlet private weak var playVideoView: WKYTPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configUI()
        configThumbnail()
    }

    override func viewWillAppear(_ animated: Bool) {
        checkExistId()
    }

    func checkExistId() {
        viewModel.checkIdFavorite { (done) in
            if done {
                let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-addedfav"), style: .plain, target: self, action: #selector(buttonDidClick))
                favoriteButton.tintColor = UIColor.red
                navigationItem.rightBarButtonItem = favoriteButton
            } else {
                let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-addfav"), style: .plain, target: self, action: #selector(buttonDidClick))
                favoriteButton.tintColor = UIColor.red
                navigationItem.rightBarButtonItem = favoriteButton
            }
        }
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

        playVideoView.load(withVideoId: viewModel.video.id)

        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell5")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-heart"), style: .plain, target: self, action: #selector(buttonDidClick))
        favoriteButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc private func buttonDidClick() {
        viewModel.saveRealm { (done, isAdd) in
            if done {
                if isAdd {
                    let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-addedfav"), style: .plain, target: self, action: #selector(self.buttonDidClick))
                    favoriteButton.tintColor = UIColor.red
                    self.navigationItem.rightBarButtonItem = favoriteButton
                } else {
                    let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-heart"), style: .plain, target: self, action: #selector(self.buttonDidClick))
                    favoriteButton.tintColor = UIColor.red
                    self.navigationItem.rightBarButtonItem = favoriteButton
                }
            }
        }
    }

    func configThumbnail() {
        videoImage.sd_setImage(with: URL(string: viewModel.video.imageURL))
        timeLabel.text = viewModel.video.duration.replacingOccurrences(of: "PT", with: "")
            .replacingOccurrences(of: "H", with: ":")
            .replacingOccurrences(of: "M", with: ":")
            .replacingOccurrences(of: "S", with: "")
        titleLabel.text = viewModel.video.title
        viewCountLabel.text = viewModel.video.viewCount + " views"
        likeLabel.text = viewModel.video.likeCount + " Like"
        dislikeLabel.text = viewModel.video.dislikeCount + " Dislike"
        publicDateLabel.text = viewModel.video.publishedAt
        descriptionLabel.text = viewModel.video.descriptionDetail
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
        return App.String.commentHeader
    }
}
