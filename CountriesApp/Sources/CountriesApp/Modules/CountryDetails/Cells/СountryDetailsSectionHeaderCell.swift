import UIKit

final class СountryDetailsSectionHeaderCell: UITableViewCell {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.lineBreakMode = .byWordWrapping
        label.font = Constants.titleFont
        label.numberOfLines = 0

        return label
    }()

    private let placeholderView = UIView()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(placeholderView)
        placeholderView.snp.makeConstraints { make in
            make.edges
                .equalToSuperview()
            make.height
                .greaterThanOrEqualTo(Constants.minRowHeight)
        }

        placeholderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading
                .equalToSuperview()
                .inset(Spacing.medium)
            make.top.bottom.trailing
                .equalToSuperview()
                .inset(Spacing.small)
        }
    }

    // MARK: - Configuration

    func configure(with title: String) {
        titleLabel.text = title
        isUserInteractionEnabled = false
    }
}

private extension СountryDetailsSectionHeaderCell {

    enum Constants {

        static let titleFont = UIFont.bold(size: 20)
        static let minRowHeight: CGFloat = 50
    }
}
