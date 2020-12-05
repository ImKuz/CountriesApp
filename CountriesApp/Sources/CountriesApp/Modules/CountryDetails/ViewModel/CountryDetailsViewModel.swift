import UIKit

enum CountryDetailsTableViewSection: Hashable, CaseIterable {

    case header
    case languages
    case currencies
    case borders
}

typealias CountryDetailsDataSnapshot = NSDiffableDataSourceSnapshot<CountryDetailsTableViewSection,
                                                                    CountryDetailsRowData>
