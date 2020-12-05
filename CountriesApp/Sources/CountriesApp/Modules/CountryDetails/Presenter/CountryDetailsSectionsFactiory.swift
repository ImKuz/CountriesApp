import UIKit
import Model
import Localization

struct CountryDetailsSectionsFactory {

    static func makeSecitons(
        from model: CountryModel
    ) -> [(section: CountryDetailsTableViewSection, rows: [CountryDetailsRowData])] {
        [
            (.currencies, makeCurrenciesRows(from: model.currencies)),
            (.languages, makeLanguagesRows(from: model.languages))
        ]
    }

    static func makeBordersSectionRowData(
        from names: [String]
    ) -> [CountryDetailsRowData] {
        var rows = [makeTitleRow(title: TextConstants.bordersTitle)]
        rows.append(contentsOf: makeBordersRows(from: names))

        return rows
    }
}

// MARK: - Rows

private extension CountryDetailsSectionsFactory {

    static func makeCurrenciesRows(from models: [Currency]) -> [CountryDetailsRowData] {
        guard !models.isEmpty else { return [] }

        var rows = [makeTitleRow(title: TextConstants.currenciesTitle)]

        let dataRows = models.compactMap { model -> CountryDetailsRowData? in
            guard let name = model.name else { return nil }
            let row = makeCommonRow(title: name, subtitle: model.code)

            return .common(row)
        }

        rows.append(contentsOf: dataRows)
        return rows
    }

    static func makeLanguagesRows(from models: [Language]) -> [CountryDetailsRowData] {
        guard !models.isEmpty else { return [] }

        var rows = [makeTitleRow(title: TextConstants.languagesTitle)]

        let dataRows = models.map { model -> CountryDetailsRowData in
            let row = makeCommonRow(title: model.name, subtitle: model.nativeName)

            return .common(row)
        }

        rows.append(contentsOf: dataRows)
        return rows
    }

    static func makeTitleRow(title: String) -> CountryDetailsRowData {
        CountryDetailsRowData.common(
            NSAttributedString(string: title, attributes: Attributes.title)
        )
    }

    static func makeBordersRows(from models: [String]) -> [CountryDetailsRowData] {
        models.map {
            let row = makeCommonRow(title: $0)

            return .border(row)
        }
    }

    static func makeCommonRow(title: String, subtitle: String? = nil) -> NSAttributedString {
        let string = NSMutableAttributedString(
            string: title,
            attributes: Attributes.elementTitle
        )

        if let subtitle = subtitle {
            let subtitle = NSAttributedString(
                string: "\n\(subtitle)",
                attributes: Attributes.elementSubtitle
            )

            string.append(subtitle)
        }

        return string
    }
}

// MARK: - Constants

private extension CountryDetailsSectionsFactory {

    enum TextConstants {

        static let languagesTitle = "country_details_languages_title".localized()
        static let currenciesTitle = "country_details_currencies_title".localized()
        static let bordersTitle = "country_details_borders_title".localized()
    }

    enum Attributes {

        static let title: StringAttributes = TextStyle.attributes(
            weight: .bold,
            size: 20
        )

        static let elementTitle: StringAttributes = TextStyle.attributes(
            weight: .medium,
            size: 17
        )

        static let elementSubtitle: StringAttributes = TextStyle.attributes(
            weight: .regular,
            size: 15,
            color: .lightGray
        )
    }
}
