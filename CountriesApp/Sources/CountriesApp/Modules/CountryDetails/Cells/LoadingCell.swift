import UIKit

class LoadingCell: UITableViewCell {

    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        loadingIndicator.startAnimating()
        contentView.backgroundColor = .clear
        setupLayout()
    }

    private func setupLayout() {
        contentView.snp.makeConstraints { make in
            make.height
                .equalTo(Constants.height)
        }

        contentView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center
                .equalToSuperview()
        }
    }
}

extension LoadingCell {

    enum Constants {

        static let height: CGFloat = 44
    }
}
