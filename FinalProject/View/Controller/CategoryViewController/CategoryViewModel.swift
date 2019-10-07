import Foundation

final class CategoryViewModel {

    var categoryStr = ["Sports", "Musics", "Amazing", "Gaming"]
}

extension CategoryViewModel {

    func numberOfItems(in section: Int) -> Int {
        return categoryStr.count
    }
}
