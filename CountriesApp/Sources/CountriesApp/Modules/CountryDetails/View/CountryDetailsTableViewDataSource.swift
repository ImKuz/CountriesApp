import UIKit

typealias CountryDetailsDiffableDataSource = UITableViewDiffableDataSource<CountryDetailsTableViewSection,
                                                                           CountryDetailsRowData>

class CountryDetailsTableViewDataSource {

    static func makeDataSource(_ tableView: UITableView) -> CountryDetailsDiffableDataSource {
        CountryDetailsDiffableDataSource(
            tableView: tableView,
            cellProvider: cellProvider
        )
    }

    private static func cellProvider(
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ rowData: CountryDetailsRowData
    ) -> UITableViewCell {
        switch rowData {
        case .header(let viewModel):
            let cell = tableView.dequeueReusableCellWithType(
                CountryDetailsHeaderCell.self,
                forIndexPath: indexPath
            )

            cell?.configure(with: viewModel)
            return cell ?? UITableViewCell()
        case .border(let string):
            let cell = tableView.dequeueReusableCellWithType(
                CountryDetailsCell.self,
                forIndexPath: indexPath
            )

            cell?.configure(with: string, isTappable: true)
            return cell ?? UITableViewCell()
        case .common(let string):
            let cell = tableView.dequeueReusableCellWithType(
                CountryDetailsCell.self,
                forIndexPath: indexPath
            )

            cell?.configure(with: string, isTappable: false)
            return cell ?? UITableViewCell()
        case .loader:
            let cell = tableView.dequeueReusableCellWithType(
                LoadingCell.self,
                forIndexPath: indexPath
            )

            return cell ?? UITableViewCell()
        }
    }
}
