import Foundation

public extension String {

    func localized() -> String {
        Localization.localizedString(for: self)
    }
}
