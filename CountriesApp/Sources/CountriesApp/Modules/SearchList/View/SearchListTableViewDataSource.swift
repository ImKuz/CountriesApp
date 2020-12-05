import UIKit

enum SearchListTableViewSection: Hashable {

    case main
}

typealias SearchListDiffableDataSource = UITableViewDiffableDataSource<SearchListTableViewSection,
                                                                            SearchListRowData>

struct SearchListTableViewDataSource {

    static func makeDataSource(_ tableView: UITableView) -> SearchListDiffableDataSource {
        SearchListDiffableDataSource(
            tableView: tableView,
            cellProvider: cellProvider
        )
    }

    private static func cellProvider(
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ rowData: SearchListRowData
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithType(
            SearchListCell.self,
            forIndexPath: indexPath
        ) else {
            return UITableViewCell()
        }

        cell.configure(with: rowData)

        return cell
    }
}
