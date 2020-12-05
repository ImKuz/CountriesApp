import UIKit

enum CountryDetailsRowData: Hashable {

    case header(CountryDetailsHeaderCell.ViewModel)
    case loader
    case common(NSAttributedString)
    case border(NSAttributedString)
}
