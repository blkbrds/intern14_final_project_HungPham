import SDWebImage
import UIKit

final class TrendingLoadMoreViewController: ViewController {

    private var viewmodel = TrendingLoadMoreViewModel()
    private var isLoadingAPI = false

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.trendingVideos
        navigationController?.navigationBar.backgroundColor = .red

        collectionView.register(UINib(nibName: "TrendingCell", bundle: nil), forCellWithReuseIdentifier: "cell3")
        collectionView.delegate = self
        collectionView.dataSource = self

        getData(isLoadMore: false)
    }

    func getData(isLoadMore: Bool) {
        if isLoadingAPI != true {
            isLoadingAPI = true
            viewmodel.getDataTrending(isLoadMore: isLoadMore) { [weak self] done in
                guard let this = self else { return }
                this.isLoadingAPI = false
                if done {
                    this.collectionView.reloadData()
                } else {
                    print("aaaa aaaa aaaa")
                }
            }
        }
    }
}

extension TrendingLoadMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.numberOfItemsTrending(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? TrendingCell else { return UICollectionViewCell() }
        let myTrending = viewmodel.getTrending(with: indexPath)
        let cellViewModel = TrendingCellViewModel(myTrending: myTrending)
        cell.viewmodel = cellViewModel
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewmodel.myTrendings.count - 4 {
            self.getData(isLoadMore: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
