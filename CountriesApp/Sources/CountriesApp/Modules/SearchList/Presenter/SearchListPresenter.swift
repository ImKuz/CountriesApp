import Model
import Localization

struct SearchListPresenterModel {

    let countries: [CountryModel]
}

final class SearchListPresenter: SearchListPresentable {

    var onViewStateChange: ((SearchListViewState) -> Void)?

    func configure(with model: SearchListPresenterModel) {
        let viewModel = SearchListViewModel(
            dataSnapshot: prepareDataSnapshot(from: model.countries)
        )

        onViewStateChange?(.data(viewModel))
    }
}

private extension SearchListPresenter {

    func prepareDataSnapshot(from countries: [CountryModel]) -> SearchListViewModel.DataSnapshot {
        var snapshot = SearchListViewModel.DataSnapshot()
        snapshot.deleteAllItems()
        let rows = countries.map {
            SearchListRowData(title: $0.name, subtitle: $0.code)
        }
        snapshot.appendSections([.main])
        snapshot.appendItems(rows)

        return snapshot
    }
}

private extension SearchListPresenter {

    enum TextConstants {

        static let title = "search_list_title".localized()
    }
}
