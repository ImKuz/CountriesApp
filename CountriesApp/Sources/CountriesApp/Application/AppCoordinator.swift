import Model
import UIKit
import Net

final class AppCoordinator: Coordinator {

    let splitViewController = UISplitViewController(style: .doubleColumn)
    let detailsNavigationController = UINavigationController()

    private let countriesService: CountriesAPI
    private var currentDetailsViewId: String?

    init() {
        countriesService = CountriesAPIService()
        splitViewController.preferredDisplayMode = .twoBesideSecondary
        splitViewController.delegate = self
    }

    func start() {
        setupSearchModule()
    }
}

// MARK: - Making modules

extension AppCoordinator {

    func makeDetailsModule(from model: CountryModel) -> UIViewController {
        var controller: UIViewController?

        let input = FlowsFactory.CountryDetailsModuleInput(
            model: model,
            countriesService: countriesService,
            onNavigation: { [weak self] action in
                switch action {
                case .details(let model):
                    self?.pushDetails(with: model)
                }
            }
        )

        controller = FlowsFactory.makeCountryDetailsModule(with: input)
        return controller ?? FlowsFactory.makeEmptyModule()
    }

    func setupSearchModule() {
        let input = FlowsFactory.SearchListModuleInput(
            countriesService: countriesService,
            onNavigation: { [weak self] route in
                switch route {
                case .details(let model):
                    self?.replaceRootDetailsController(with: model)
                }
            }
        )

        let controller = UINavigationController(
            rootViewController: FlowsFactory.makeSearchListModule(with: input)
        )
        controller.navigationBar.prefersLargeTitles = true
        let emptyController = FlowsFactory.makeEmptyModule()

        splitViewController.setViewController(controller, for: .primary)
        splitViewController.setViewController(emptyController, for: .secondary)
    }
}

// MARK: - SplitView actions

extension AppCoordinator {

    func pushDetails(with model: CountryModel) {
        let module = makeDetailsModule(from: model)
        detailsNavigationController.pushViewController(
            module,
            animated: true
        )
    }

    func replaceRootDetailsController(with model: CountryModel) {
        guard model.code != currentDetailsViewId else {
            return
        }
        currentDetailsViewId = model.code
        let module = makeDetailsModule(from: model)

        detailsNavigationController.viewControllers = [module]
        splitViewController.setViewController(detailsNavigationController, for: .secondary)
        splitViewController.showDetailViewController(module, sender: self)
    }
}

// MARK: - UISplitViewControllerDelegate

extension AppCoordinator: UISplitViewControllerDelegate {

    func splitViewController(
        _ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        .primary
    }
}
