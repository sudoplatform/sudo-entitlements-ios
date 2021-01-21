//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class GetEntitlementsTest: BaseTestCase {

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        mockUserClient.isSignedInReturn = true
    }

    // MARK: - Tests

    func test_getEntitlements_CreatesGetUseCase() {
        instanceUnderTest.getEntitlements() { _ in }
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_redeemEntitlements_CreatesGetUseCase() {
        instanceUnderTest.redeemEntitlements() { _ in }
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 1)
    }

    func test_getEntitlements_RespectsUseCaseFailure() {
        let mockUseCase = MockGetEntitlementsUseCase(result: .failure(AnyError("Get entitlements failed")))
        mockUseCaseFactory.generateGetEntitlementsUseCaseResult = mockUseCase
        waitUntil { done in
            self.instanceUnderTest.getEntitlements() { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get entitlements failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_redeemEntitlements_RespectsUseCaseFailure() {
        let mockUseCase = MockRedeemEntitlementsUseCase(result: .failure(AnyError("Redeem entitlements failed")))
        mockUseCaseFactory.generateRedeemEntitlementsUseCaseResult = mockUseCase
        waitUntil { done in
            self.instanceUnderTest.redeemEntitlements() { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Redeem entitlements failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
}
