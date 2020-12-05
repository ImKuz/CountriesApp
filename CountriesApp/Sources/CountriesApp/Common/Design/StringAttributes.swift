import UIKit

typealias StringAttributes = [NSAttributedString.Key: Any]

enum TextStyle {

    static func attributes(
        weight: UIFont.Weight,
        size: CGFloat,
        color: UIColor? = nil
    ) -> StringAttributes {
        [
            .font: UIFont.systemFont(ofSize: size, weight: weight),
            .foregroundColor: color ?? .black,
            .paragraphStyle: multilineParagraphStyle
        ]
    }

    private static let multilineParagraphStyle: NSParagraphStyle = {
        let parahgraph = NSMutableParagraphStyle()
        parahgraph.lineHeightMultiple = 1.23
        return parahgraph
    }()
}
