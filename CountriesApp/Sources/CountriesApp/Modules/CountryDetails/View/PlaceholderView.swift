import UIKit
import SnapKit

final class PlaceholderView: UIView {

    let imageView = UIImageView()

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

    private func setupColors() {
        backgroundColor = traitCollection.userInterfaceStyle == .dark
            ? .black
            : .systemGray6
    }

    private func setup() {
        backgroundColor = .systemGray6
        setupLayout()
        setupColors()

        imageView.image = Constants.image
        imageView.tintColor = .systemGray5
    }

    private func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center
                .equalToSuperview()
            make.size
                .equalTo(Constants.imageDimension)
        }
    }
}

private extension PlaceholderView {

    enum Constants {

        static let image = UIImage(systemName: "globe")
        static let imageDimension: CGFloat = 150
    }
}
