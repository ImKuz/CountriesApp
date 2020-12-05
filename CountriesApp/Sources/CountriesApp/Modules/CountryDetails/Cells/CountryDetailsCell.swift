import UIKit

final class CountryDetailsCell: UITableViewCell {

    struct ViewModel: Hashable {

        let title: String
        let subtitle: String?
        let isSelectable: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = Constants.subtitleColor
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with viewModel: ViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle

        isUserInteractionEnabled = viewModel.isSelectable

        if viewModel.isSelectable {
            accessoryType = .disclosureIndicator
        }
    }
}

private extension CountryDetailsCell {

    enum Constants {

        static let subtitleColor: UIColor = .systemGray2
        static let minRowHeight: CGFloat = 50
    }
}
