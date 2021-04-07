//
//  SpaceXLaunchesTests.swift
//  SpaceXLaunchesTests
//
//  Created by Angie Mugo on 05/04/2021.
//

import XCTest
import RxSwift
@testable import SpaceXLaunches

class SpaceXLaunchesTests: XCTestCase {
    private var listViewModel: LaunchesListViewModel?
    private var rocketViewModel: RocketDetailViewModel?
    private let disposeBag = DisposeBag()

    func testGetRocket() {
        rocketViewModel = DependencyInjection.shared.resolve(RocketDetailViewModel.self)
        let id = "5e9d0d95eda69955f709d1eb"
        rocketViewModel?.setID(id)
        rocketViewModel?.fetchRocket()
        rocketViewModel?.dataSource.subscribe(onNext: { rocket in
            XCTAssertEqual(rocket?.name, "Falcon 1")
            XCTAssertEqual(rocket?.description, "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.")
            XCTAssertEqual(rocket?.images,  [
                "https://imgur.com/DaCfMsj.jpg",
                "https://imgur.com/azYafd8.jpg"
            ])
        }).disposed(by: disposeBag)
    }

    func testGetLaunches() {
        listViewModel = DependencyInjection.shared.resolve(LaunchesListViewModel.self)
        listViewModel?.fetchLaunches()
        listViewModel?.dataSource.subscribe(onNext: { launches in
            XCTAssertEqual(launches.count, 1)
        }).disposed(by: disposeBag)
    }
}
