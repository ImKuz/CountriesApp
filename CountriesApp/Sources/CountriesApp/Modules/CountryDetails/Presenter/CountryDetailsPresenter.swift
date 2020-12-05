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

        let headerViewModel = CountryDetailsHeaderCell.ViewModel(
            name: model.name,
            nativeName: model.nativeName,
            flagURL: model.flag
        )

        snapshot.appendSections([.header])
        snapshot.appendItems([.header(headerViewModel)])

        SectionsFactory
            .makeSecitons(from: model)
            .forEach {
                snapshot.appendSections([$0.section])
                snapshot.appendItems($0.rows, toSection: $0.section)
            }

        snapshot.appendSections([.borders])

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

        let data = SectionsFactory.makeBordersSectionRowData(from: names)
        snapshot.appendItems(data, toSection: .borders)

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
