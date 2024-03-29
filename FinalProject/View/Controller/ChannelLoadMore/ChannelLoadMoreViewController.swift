import UIKit

final class ChannelLoadMoreViewController: UIViewController {

    var viewModel = ChannelLoadMoreViewModel()
    var isLoadApi = false

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.channelVideos
        navigationController?.navigationBar.backgroundColor = .red

        collectionView.register(UINib(nibName: "ChannelCell", bundle: nil), forCellWithReuseIdentifier: "channelVideos")
        collectionView.dataSource = self
        collectionView.delegate = self

        getData(isLoadMore: false)
    }

    func getData(isLoadMore: Bool) {
        if isLoadApi != true {
            isLoadApi = true
            viewModel.getDataChannel(isLoadMore: isLoadMore) { [weak self] done in
                guard let this = self else { return }
                this.isLoadApi = false
                if done {
                    this.collectionView.reloadData()
                } else {
                    print("Can't Load More Video!")
                }
            }
        }
    }
}

extension ChannelLoadMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelVideos", for: indexPath) as? ChannelCell else { return UICollectionViewCell() }
        let myChannels = viewModel.getChannel(with: indexPath)
        let cellViewModel = ChannelCellModel(myChannel: myChannels)
        cell.viewModel = cellViewModel
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.myChannels.count - 4 {
            getData(isLoadMore: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 9, height: 49)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
