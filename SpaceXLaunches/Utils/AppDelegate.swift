//
//  AppDelegate.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard NSClassFromString("XCTest") == nil else {
            registerTestDependencies()
            self.window?.rootViewController = UIViewController()
            self.window?.makeKeyAndVisible()
            return true
        }
        registerDependencies()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let coordinator = LaunchesListViewCoordinator(window!)
        coordinator.start()
        window?.makeKeyAndVisible()
        return true
    }

    private func registerDependencies() {
        let container = Container()
        container.registerDependency()
        DependencyInjection.shared.setContainer(container)
    }

    private func registerTestDependencies() {
        let container = Container()
        container.registerTestDependency()
        DependencyInjection.shared.setContainer(container)
    }
}
