import UIKit

extension UIFont {

    public static func regular(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .regular)
    }

    public static func semibold(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .semibold)
    }

    public static func bold(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .bold)
    }

    public static func medium(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .medium)
    }
}
