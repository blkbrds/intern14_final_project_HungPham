import UIKit

final class HomeViewController: UIViewController {

    let viewmodel = HomeViewModel()

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configUI()
    }

    func configUI() {
        title = "YOUTUBE"
        navigationController?.navigationBar.backgroundColor = .red

        let catagoryButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-category"), style: .plain, target: self, action: #selector(buttonDidClick))
        catagoryButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = catagoryButton

        collectionView.register(UINib(nibName: "TrendingCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        collectionView.register(UINib(nibName: "ChannelCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
        collectionView.dataSource = self
        collectionView.delegate = self

        let titleHeader = UINib(nibName: "TitleHeaderView", bundle: nil)
        collectionView.register(titleHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "titleheader")
    }

    @objc private func buttonDidClick() {
        print("button Did Click !")
    }

    func configData() {
        viewmodel.loadDataTrending { (done) in
            if done {
                self.updateUI()
            } else {
                print("Can't Load data Trending!")
            }
        }
        viewmodel.loadDataChannel { (done) in
            if done {
                self.updateUI()
            } else {
                print("Can't Load data Channel!")
            }
        }
    }

    func updateUI() {
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewmodel.numberOfItemsTrending(in: section)
        } else {
            return viewmodel.numberOfItemsChannel(in: section)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? TrendingCell else { return UICollectionViewCell() }
            let myTrending = viewmodel.getTrending(with: indexPath)
            let cellViewModel = TrendingCellViewModel(myTrending: myTrending)
            cell.viewModel = cellViewModel
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? ChannelCell else { return UICollectionViewCell() }
            let myChannel = viewmodel.getChannel(with: indexPath)
            let cellViewModel = ChannelCellModel(myChannel: myChannel)
            cell.viewModel = cellViewModel
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = DetailViewController()
            vc.viewModel = DetailViewModel(video: viewmodel.myTrendings[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "titleheader", for: indexPath) as? TitleHeaderView
                else {
                    fatalError("Invalid view type")
            }
            headerView.delegate = self
            if indexPath.section == 0 {
                headerView.titleHeaderLabel.text = App.String.topTrending
                headerView.isClickedTitle = true
            } else {
                headerView.titleHeaderLabel.text = App.String.channelTitle
                headerView.isClickedTitle = false
            }
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 410, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 200, height: 180)
        }
        return CGSize(width: 405, height: 49)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        }
        return 10
    }
}

extension HomeViewController: TitleHeaderViewDelegate {

    func tapMoreTrending(_ titleHeaderView: TitleHeaderView, sender: UIButton) {
        navigationController?.pushViewController(TrendingLoadMoreViewController(), animated: true)
    }

    func tapMoreChannel(_ titleHeaderView: TitleHeaderView, sender: UIButton) {
        navigationController?.pushViewController(ChannelLoadMoreViewController(), animated: true)
    }
}
