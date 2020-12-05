import UIKit

enum CountryDetailsRowData: Hashable {

    case tableHeader(CountryDetailsHeaderCell.ViewModel)
    case sectionHeader(String)
    case content(CountryDetailsCell.ViewModel)
    case loader
}
