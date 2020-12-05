import UIKit
import Kingfisher
import SVGKit

struct SVGImageProcessor: ImageProcessor {

    var identifier: String = "\(Bundle.main.bundleIdentifier!).imageProcessor"

    func process(
        item: ImageProcessItem,
        options: KingfisherParsedOptionsInfo
    ) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
