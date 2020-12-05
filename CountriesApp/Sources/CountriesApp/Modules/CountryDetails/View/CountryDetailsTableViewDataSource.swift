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
        case .tableHeader(let viewModel):
            let cell = tableView.dequeueReusableCellWithType(
                CountryDetailsHeaderCell.self,
                forIndexPath: indexPath
            )

            cell?.configure(with: viewModel)
            return cell ?? UITableViewCell()
        case .content(let viewModel):
            let cell = tableView.dequeueReusableCellWithType(
                CountryDetailsCell.self,
                forIndexPath: indexPath
            )

            cell?.configure(with: viewModel)
            return cell ?? UITableViewCell()
        case .sectionHeader(let title):
            let cell = tableView.dequeueReusableCellWithType(
                СountryDetailsSectionHeaderCell.self,
                forIndexPath: indexPath
            )

            cell?.configure(with: title)
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
