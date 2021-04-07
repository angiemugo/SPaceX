//
//  Container+Extension.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import Swinject

extension Container {
    func registerDependency() {
        register(RocketDetailViewModel.self) { resolver in
            let dataSource = LaunchesRemoteDataSource()
            return RocketDetailViewModel(dataSource)
        }

        register(LaunchesListViewModel.self) { resolver in
            let dataSource = LaunchesRemoteDataSource()
            return LaunchesListViewModel(dataSource)
        }
    }

    func registerTestDependency() {
        register(RocketDetailViewModel.self) { resolver in
            let dataSource = LaunchesLocalDataSource()
            return RocketDetailViewModel(dataSource)
        }

        register(LaunchesListViewModel.self) { resolver in
            let dataSource = LaunchesLocalDataSource()
            return LaunchesListViewModel(dataSource)
        }
    }
}
