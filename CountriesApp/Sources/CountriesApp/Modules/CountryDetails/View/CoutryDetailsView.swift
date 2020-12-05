import UIKit
import SnapKit

final class CountryDetailsView: UIView {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupColors()
    }

    private func setup() {
        tableView.showsVerticalScrollIndicator = false
        setupColors()
        setupLayout()
    }

    private func setupColors() {
        if traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = .black
            backgroundColor = .black
        } else {
            tableView.backgroundColor = .systemGray6
            backgroundColor = .systemGray6
        }
    }

    private func setupLayout() {
        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.centerX
                .equalToSuperview()
            make.width
                .greaterThanOrEqualTo(Constants.minSectionWidth)
                .priority(.high)
            make.width
                .lessThanOrEqualTo(minScreenWidth)
                .priority(.required)
            make.top.bottom
                .equalToSuperview()
        }
    }
}

private extension CountryDetailsView {

    var minScreenWidth: CGFloat {
        UIScreen.main.bounds.width - Spacing.medium
    }

    struct Constants {

        static let minSectionWidth: CGFloat = 500
    }
}
