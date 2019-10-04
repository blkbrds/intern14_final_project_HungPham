import Foundation
import RealmSwift

protocol FavoriteViewModelDelegate: class {
    func viewModel(_ viewModel: FavoriteViewModel, needperformAction: FavoriteViewModel.Action)
}

final class FavoriteViewModel {

    weak var delegate: FavoriteViewModelDelegate?

    var myData: [Trending] = []
    var notificationToken: NotificationToken?

    func fetchData() {
        guard let datas = RealmManager.shared.fetchObjects(Trending.self) else { return }
        self.myData = [Trending](datas)
        delegate?.viewModel(self, needperformAction: .reloadData)
    }

    func observe() {
        notificationToken = RealmManager.shared.observe(type: Trending.self, completion: { [weak self] _ in
            guard let this = self else { return }
            this.fetchData()
        })
    }

    func deleteALL(completion: @escaping (Bool) -> Void) {
        guard let datas = RealmManager.shared.fetchObjects(Trending.self) else { return }
        RealmManager.shared.deleteAll(objects: [Trending](datas)) { (result) in
            switch result {
            case .failure(let error):
                print("🔴 DELETE FAILED: \(error.localizedDescription)")
                completion(false)
            case .success:
                print("🔵 DELETE SUCCESS")
                self.myData = []
                completion(true)
            }
        }
    }

    func deleteVideoId(with index: Int, completion: @escaping (Bool) -> Void) {
        guard let datas = RealmManager.shared.fetchObjects(Trending.self) else { return }
        RealmManager.shared.delete(object: datas[index]) { (result) in
            switch result {
            case .failure(let error):
                print("🔴 DELETEd Index FAILED: \(error.localizedDescription)")
                completion(false)
            case .success:
                print("🔵 DELETEd Index SUCCESS")
                self.myData = []
                completion(true)
            }
        }
    }
}

extension FavoriteViewModel {

    func numberOfItems(in section: Int) -> Int {
        return myData.count
    }

    func getData(with indexPath: IndexPath) -> Trending {
        return myData[indexPath.row]
    }

    enum Action {
        case reloadData
    }
}
