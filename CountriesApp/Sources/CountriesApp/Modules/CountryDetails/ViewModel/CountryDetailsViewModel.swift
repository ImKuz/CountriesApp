import UIKit

enum CountryDetailsTableViewSection: Hashable {

    case header
    case languages
    case currencies
    case borders
}

typealias CountryDetailsDataSnapshot = NSDiffableDataSourceSnapshot<CountryDetailsTableViewSection,
                                                                    CountryDetailsRowData>
