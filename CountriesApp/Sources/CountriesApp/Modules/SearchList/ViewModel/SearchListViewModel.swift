import UIKit

enum SearchListViewState {

    case data(SearchListViewModel)
    case loading(Bool)
    case error(String)
}

struct SearchListViewModel {

    typealias DataSnapshot = NSDiffableDataSourceSnapshot<SearchListTableViewSection,
                                                          SearchListRowData>

    let dataSnapshot: DataSnapshot
}
