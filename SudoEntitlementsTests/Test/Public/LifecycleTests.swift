//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class DefaultSudoEntitlementsClientLifecycleTests: BaseTestCase {

    // MARK: - Tests

    func test_reset_ResetsObjects() throws {
        try instanceUnderTest.reset()
        XCTAssertEqual(mockEntitlementsRepository.resetCallCount, 1)
    }
}
