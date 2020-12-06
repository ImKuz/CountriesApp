import UIKit

class LoadingCell: UITableViewCell {

    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        loadingIndicator.startAnimating()
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center
                .equalToSuperview()
        }
    }
}
