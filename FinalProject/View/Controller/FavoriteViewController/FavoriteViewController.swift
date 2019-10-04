import UIKit

final class FavoriteViewController: UIViewController {

    var viewModel = FavoriteViewModel()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fetchData()
    }

    func configUI() {
        title = App.String.favoriteTitle
        navigationController?.navigationBar.backgroundColor = .red

        let deleteItems = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-delete"), style: .plain, target: self, action: #selector(buttonDidClick))
        deleteItems.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = deleteItems

        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "cell5")
        tableView.dataSource = self
        tableView.delegate = self
    }

    @objc private func buttonDidClick() {
        print("button Did Click !")
        alert()
    }

    func alert() {
        let alertController = UIAlertController(title: "Delete All", message: "Do You Want To Delete All Favorite Videos ?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
            NSLog("Cancel Pressed")
        }
        let okAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) { _ in
            self.viewModel.deleteALL(completion: { (done) in
                if done {
                    self.viewModel.fetchData()
                }
            })
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

    func fetchData() {
        viewModel.delegate = self
        viewModel.fetchData()
        viewModel.observe()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        let myData = viewModel.getData(with: indexPath)
        let cellViewModel = FavoriteCellModel(myTrending: myData)
        cell.viewModel = cellViewModel
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            viewModel.deleteVideoId(with: indexPath.row) { (done) in
                if done {
                    tableView.reloadData()
                }
            }
        }
    }
}

extension FavoriteViewController: FavoriteViewModelDelegate {

    func viewModel(_ viewModel: FavoriteViewModel, needperformAction: FavoriteViewModel.Action) {
        tableView.reloadData()
    }
}
