import UIKit

final class CategoryViewController: UIViewController {

    var viewModel = CategoryViewModel()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        title = App.String.catelogyStr
        navigationController?.navigationBar.backgroundColor = .red

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoryStr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = viewModel.categoryStr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(SportViewController(), animated: true)
        } else if indexPath.row == 1 {
            navigationController?.pushViewController(MusicViewController(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(AmazingViewController(), animated: true)
        } else if indexPath.row == 3 {
            navigationController?.pushViewController(GamingViewController(), animated: true)
        }
    }
}
