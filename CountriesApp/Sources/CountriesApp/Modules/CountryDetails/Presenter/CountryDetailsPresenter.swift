import Model

final class CountryDetailsPresenter: CountryDetailsPresenterOutput {

    typealias SectionsFactory = CountryDetailsSectionsFactory

    weak var snapshotProvider: CountryDetailsSnapshotProvider?

    var onSnapshotUpdate: ((CountryDetailsDataSnapshot) -> Void)?
    var onTitleSetup: ((String) -> Void)?
}

extension CountryDetailsPresenter: CountryDetailsPresenterInput {

    func configureInitialState(with model: CountryModel) {
        guard var snapshot = snapshotProvider?.currentSnapshot else {
            return
        }

        snapshot.appendSections(CountryDetailsTableViewSection.allCases)
        snapshot.appendItems([.loader], toSection: .borders)

        SectionsFactory
            .makeContentSecitons(from: model)
            .forEach { snapshot.appendItems($0.rows, toSection: $0.section) }

        onTitleSetup?(model.name)
        onSnapshotUpdate?(snapshot)
    }

    func configureBorders(with names: [String]) {
        guard
            var snapshot = snapshotProvider?.currentSnapshot,
            !names.isEmpty
        else {
            return
        }

        guard let data = SectionsFactory.makeBordersSection(from: names) else {
            return
        }

        snapshot.appendItems(data.rows, toSection: data.section)
        onSnapshotUpdate?(snapshot)
    }

    func setLoadingBorders(_ isLoading: Bool) {
        guard var snapshot = snapshotProvider?.currentSnapshot else {
            return
        }

        if isLoading {
            snapshot.appendItems([.loader], toSection: .borders)
        } else {
            snapshot.deleteItems([.loader])
        }

        onSnapshotUpdate?(snapshot)
    }
}
