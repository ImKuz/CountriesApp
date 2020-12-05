import UIKit

public extension UITableView {

    func registerClassForCell(_ cellClass: UITableViewCell.Type) {
        register(
            cellClass,
            forCellReuseIdentifier: cellClass.defaultIdentifier
        )
    }

    func dequeueReusableCellWithType<T: UITableViewCell>(_ cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.defaultIdentifier) as? T
    }

    func dequeueReusableCellWithType<T: UITableViewCell>(
        _ cellClass: T.Type,
        forIndexPath indexPath: IndexPath
    ) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.defaultIdentifier,
                                             for: indexPath) as? T
        else {
            return nil
        }

        return cell
    }
}
