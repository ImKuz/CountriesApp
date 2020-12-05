import Model
import UIKit
import Net

final class AppCoordinator: Coordinator {

    let splitViewController = UISplitViewController(style: .doubleColumn)
    let detailsNavigationController = UINavigationController()

    private let countriesService: CountriesAPI

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
                    if let detailsModule = self?.makeDetailsModule(from: model) {
                        self?.detailsNavigationController.pushViewController(
                            detailsModule,
                            animated: true
                        )
                    }
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
                    if let detailsModule = self?.makeDetailsModule(from: model) {
                        self?.replaceRootDetailsController(with: detailsModule)
                    }
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

    func replaceRootDetailsController(with controller: UIViewController) {
        detailsNavigationController.viewControllers = [controller]
        splitViewController.setViewController(detailsNavigationController, for: .secondary)
        splitViewController.showDetailViewController(controller, sender: self)
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
