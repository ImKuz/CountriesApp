import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var appCoordinator = makeAppCoordinator()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appCoordinator.splitViewController
        self.window = window
        appCoordinator.start()
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate {

    func makeAppCoordinator() -> AppCoordinator {
        AppCoordinator()
    }
}
