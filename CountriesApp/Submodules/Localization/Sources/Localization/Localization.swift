import Foundation

public enum Localization {

    public static func localizedString(for key: String) -> String {
        NSLocalizedString(
            key,
            bundle: .module,
            comment: ""
        )
    }
}
