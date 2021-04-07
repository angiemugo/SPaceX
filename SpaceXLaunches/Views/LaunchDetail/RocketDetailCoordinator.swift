//
//  RocketDetailCoordinator.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import UIKit
import Swinject

class RocketDetailCoordinator {
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(_ id: String) {
        let viewModel = DependencyInjection.shared.resolve(RocketDetailViewModel.self)
        viewModel.setCoordinator(self)
        viewModel.setID(id)
        navigationController.pushViewController(RocketDetailViewController(viewModel), animated: true)
    }
}
