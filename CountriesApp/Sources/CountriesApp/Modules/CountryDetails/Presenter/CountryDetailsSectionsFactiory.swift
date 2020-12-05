import UIKit
import Model
import Localization

struct CountryDetailsSectionsFactory {

    typealias SectionData = (
        section: CountryDetailsTableViewSection,
        rows: [CountryDetailsRowData]
    )

    static func makeContentSecitons(
        from model: CountryModel
    ) -> [SectionData] {
        [
            makeHeaderSection(from: model),
            makeCurrenciesSection(from: model.currencies),
            makeLanguagesSection(from: model.languages)
        ]
        .compactMap { $0 }
    }

    static func makeBordersSection(from models: [String]) -> SectionData? {
        guard !models.isEmpty else { return nil }

        let rowItems = models.map {
            makeSectionRow(title: $0, isSelectable: true)
        }

        var sectionRows = [makeHeader(title: TextConstants.bordersTitle)]
        sectionRows.append(contentsOf: rowItems)

        return (CountryDetailsTableViewSection.borders, sectionRows)
    }
}

// MARK: - Content

private extension CountryDetailsSectionsFactory {

    static func makeHeaderSection(from model: CountryModel) -> SectionData {
        let headerViewModel = CountryDetailsHeaderCell.ViewModel(
            name: model.name,
            nativeName: model.nativeName,
            flagURL: model.flag
        )

        return (
            section: .header,
            rows: [.tableHeader(headerViewModel)]
        )
    }

    static func makeCurrenciesSection(from models: [Currency]) -> SectionData? {
        guard !models.isEmpty else { return nil }

        let rowItems = models.map {
            makeSectionRow(
                title: $0.name ?? TextConstants.currency,
                subtitle: $0.code
            )
        }
        var sectionRows = [makeHeader(title: TextConstants.currenciesTitle)]
        sectionRows.append(contentsOf: rowItems)

        return (.currencies, sectionRows)
    }

    static func makeLanguagesSection(from models: [Language]) -> SectionData? {
        guard !models.isEmpty else { return nil }

        let rowItems = models.map {
            makeSectionRow(title: $0.name, subtitle: $0.nativeName)
        }

        var sectionRows = [makeHeader(title: TextConstants.languagesTitle)]
        sectionRows.append(contentsOf: rowItems)

        return (.languages, sectionRows)
    }
}

// MARK: - Helpers

private extension CountryDetailsSectionsFactory {

    static func makeSectionRow(
        title: String,
        subtitle: String? = nil,
        isSelectable: Bool = false
    ) -> CountryDetailsRowData {
        let viewModel = CountryDetailsCell.ViewModel(
            title: title,
            subtitle: subtitle,
            isSelectable: isSelectable
        )

        return .content(viewModel)
    }

    static func makeHeader(title: String) -> CountryDetailsRowData {
        .sectionHeader(title)
    }
}

// MARK: - Constants

private extension CountryDetailsSectionsFactory {

    enum TextConstants {

        static let currency = "currency".localized()
        static let languagesTitle = "country_details_languages_title".localized()
        static let currenciesTitle = "country_details_currencies_title".localized()
        static let bordersTitle = "country_details_borders_title".localized()
    }
}
