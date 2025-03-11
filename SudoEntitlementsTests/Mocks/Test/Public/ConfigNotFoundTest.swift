//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements
@testable import SudoConfigManager
@testable import SudoUser

class ConfigNotFoundTest: XCTestCase {
    func test_init_EntitlementsConfigNotFound() throws {
        let mockUserClient = MockSudoUserClient()
        let configManagerFactory = SudoConfigManagerFactory.instance
        let config: [String: Any] = [
            "apiService": [:],
            "identityService": [
                "region": "dummy_region",
                "serviceInfoBucket": "dummy_service_info_bucket"
            ]
        ]
        configManagerFactory.registerConfigManager(name: SudoConfigManagerFactory.Constants.defaultConfigManagerName, config: config)
        var thrown:SudoEntitlementsError? = nil
        do {
            _ = try DefaultSudoEntitlementsClient(userClient: mockUserClient)
        } catch let err as SudoEntitlementsError {
            thrown = err
        }
        XCTAssertEqual(thrown, SudoEntitlementsError.entitlementsServiceConfigNotFound)
    }
    func test_init_ApiServiceConfigNotFound() throws {
        let mockUserClient = MockSudoUserClient()
        let configManagerFactory = SudoConfigManagerFactory.instance

        configManagerFactory.registerConfigManager(name: SudoConfigManagerFactory.Constants.defaultConfigManagerName, config: ["entitlementsService":[:]])
        var thrown:SudoEntitlementsError? = nil
        do {
            _ = try DefaultSudoEntitlementsClient(userClient: mockUserClient)
        } catch let err as SudoEntitlementsError {
            thrown = err
        }
        XCTAssertEqual(thrown, SudoEntitlementsError.invalidConfig)
    }
}
