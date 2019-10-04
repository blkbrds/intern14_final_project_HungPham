import UIKit

final class SearchViewController: UIViewController {

    var viewModel = SearchViewModel()
    var isLoadApi = false
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = "SEARCH"
        navigationController?.navigationBar.backgroundColor = .red

        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = searchController.searchBar

        configSearchBar()
    }

    func configSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.red
    }

    func getData(isLoadMore: Bool) {
        if isLoadApi != true {
            isLoadApi = true
            viewModel.getSearchData(isLoadMore: isLoadMore) { [weak self] done in
                guard let this = self else { return }
                this.isLoadApi = false
                if done {
                    this.tableView.reloadData()
                } else {
                    print("Can't Load More Data!")
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsSearch(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        let mySearchs = viewModel.getSearch(with: indexPath)
        let cellViewModel = SearchCellModel(mySearch: mySearchs)
        cell.viewModel = cellViewModel
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.mySearchs.count - 4 {
            self.getData(isLoadMore: true)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let trimmed = String(searchText.filter { !" \n\t\r".contains($0) })
        viewModel.keySearch = trimmed
        viewModel.getSearchData(isLoadMore: false) { (result) in
            switch result {
            case true:
                self.tableView.reloadData()
            case false:
                print("Can't Load Search Data !")
            }
        }
    }
}
