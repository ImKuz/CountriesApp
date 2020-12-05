import UIKit

class SearchListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        accessoryType = .disclosureIndicator
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with rowData: SearchListRowData) {
        textLabel?.text = rowData.title
        detailTextLabel?.text = rowData.subtitle
    }
}
