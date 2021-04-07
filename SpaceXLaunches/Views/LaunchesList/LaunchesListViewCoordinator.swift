//
//  LaunchesListViewCoordinator.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import UIKit
import Swinject

class LaunchesListViewCoordinator {
    let dataSource = LaunchesRemoteDataSource()
    let window: UIWindow
    var navController: UINavigationController?

    init(_ window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewModel = DependencyInjection.shared.resolve(LaunchesListViewModel.self)
        viewModel.setCoordinator(self)
        let viewController = LaunchesListViewController(viewModel)
        let nav = UINavigationController(rootViewController: viewController)
        navController = nav
        window.rootViewController = nav
    }

    func showRocketDetails(_ id: String) {
        let rocketCoordinator = RocketDetailCoordinator(navController ?? UINavigationController())
        rocketCoordinator.start(id)
    }
}
