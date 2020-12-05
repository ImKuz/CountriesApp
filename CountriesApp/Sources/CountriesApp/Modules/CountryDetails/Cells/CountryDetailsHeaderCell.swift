import UIKit
import Kingfisher
import SnapKit

final class CountryDetailsHeaderCell: UITableViewCell {

    // MARK: - UIComponents

    struct ViewModel: Hashable {
        let name: String
        let nativeName: String
        let flagURL: URL
    }

    private let nameLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bold(size: 24)
        label.accessibilityLabel = ""

        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .regular(size: 18)

        return label
    }()

    private let flagImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

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
        backgroundColor = .systemGray6
        isUserInteractionEnabled = false
        flagImageView.kf.indicatorType = .activity
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(flagImageView)
        flagImageView.snp.makeConstraints { make in
            make.top.centerX
                .equalToSuperview()
            make.height
                .equalTo(Constants.flagImageViewHeight)
        }

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top
                .equalTo(flagImageView.snp.bottom)
                .offset(Spacing.large)
            make.leading.trailing
                .equalToSuperview()
                .inset(Spacing.medium)
        }

        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top
                .equalTo(nameLabel.snp.bottom)
                .offset(Spacing.medium)
            make.leading.trailing.bottom
                .equalToSuperview()
                .inset(Spacing.medium)
        }
    }

    // MARK: - Configuration

    func configure(with viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.nativeName

        flagImageView.kf.setImage(
            with: viewModel.flagURL,
            options: [
                .processor(SVGImageProcessor()),
                .transition(.fade(0.5))
            ]
        )
    }
}

private extension CountryDetailsHeaderCell {

    enum Constants {

        static let flagImageViewHeight: CGFloat = 100
    }
}
