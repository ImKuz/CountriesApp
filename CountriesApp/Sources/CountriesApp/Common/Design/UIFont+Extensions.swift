import UIKit

extension UIFont {

    static func regular(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }

    static func semibold(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .semibold)
    }

    static func bold(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .bold)
    }

    static func medium(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .medium)
    }
}
