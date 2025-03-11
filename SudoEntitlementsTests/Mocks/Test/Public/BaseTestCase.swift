//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements
import SudoUser
import SudoApiClient

class BaseTestCase: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: SudoEntitlementsClient!

    var graphQLClient: SudoApiClient!
    var mockUserClient: MockSudoUserClient!
    var mockUseCaseFactory: MockUseCaseFactory!
    var mockEntitlementsRepository: MockEntitlementsRepository!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        graphQLClient = MockSudoApiClient()
        mockUserClient = MockSudoUserClient()
        mockEntitlementsRepository = MockEntitlementsRepository()
        mockUseCaseFactory = MockUseCaseFactory(repository: mockEntitlementsRepository)
        instanceUnderTest = DefaultSudoEntitlementsClient(
            graphQLClient: graphQLClient,
            userClient: mockUserClient,
            useCaseFactory: mockUseCaseFactory,
            repository: mockEntitlementsRepository,
            logger: .testLogger
        )
    }
}
