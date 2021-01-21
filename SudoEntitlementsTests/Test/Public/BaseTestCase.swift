//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements
import SudoUser
import AWSAppSync

class BaseTestCase: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: SudoEntitlementsClient!

    var appSyncClient: AWSAppSyncClient!
    var mockUserClient: MockSudoUserClient!
    var mockUseCaseFactory: MockUseCaseFactory!
    var mockEntitlementsRepository: MockEntitlementsRepository!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        appSyncClient = MockAWSAppSyncClientGenerator.generateClient()
        mockUserClient = MockSudoUserClient()
        mockEntitlementsRepository = MockEntitlementsRepository()
        mockUseCaseFactory = MockUseCaseFactory(repository: mockEntitlementsRepository)
        instanceUnderTest = DefaultSudoEntitlementsClient(
            appSyncClient: appSyncClient,
            userClient: mockUserClient,
            useCaseFactory: mockUseCaseFactory,
            repository: mockEntitlementsRepository,
            logger: .testLogger
        )
    }
}
