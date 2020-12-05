import UIKit

final class CountryDetailsCell: UITableViewCell {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.lineBreakMode = .byWordWrapping
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

    func configure(with title: NSAttributedString, isTappable: Bool) {
        titleLabel.attributedText = title
        isUserInteractionEnabled = isTappable

        if isTappable {
            accessoryType = .disclosureIndicator
            selectionStyle = .none
        }
    }
}

private extension CountryDetailsCell {

    enum Constants {

        static let minRowHeight: CGFloat = 50
    }
}
