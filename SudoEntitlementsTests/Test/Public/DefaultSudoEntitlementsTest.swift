//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class DefaultSudoEntitlementsTest: BaseTestCase {

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        mockUserClient.isSignedInReturn = true
    }

    // MARK: - Tests

    func test_getEntitlements_CreatesGetUseCase() {
        instanceUnderTest.getEntitlements() { _ in }
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_getEntitlementsConsumption_CreatesGetUseCase() {
        instanceUnderTest.getEntitlementsConsumption() { _ in }
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_getExternalId_CreatesGetUseCase() {
        instanceUnderTest.getExternalId() { _ in }
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_redeemEntitlements_CreatesGetUseCase() {
        instanceUnderTest.redeemEntitlements() { _ in }
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 0)
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

    func test_getEntitlementsConsumption_RespectsUseCaseFailure() {
        let mockUseCase = MockGetEntitlementsConsumptionUseCase(result: .failure(AnyError("Get entitlements consumption failed")))
        mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseResult = mockUseCase
        waitUntil { done in
            self.instanceUnderTest.getEntitlementsConsumption() { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get entitlements consumption failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_getExternalId_RespectsUseCaseFailure() {
        let mockUseCase = MockGetExternalIdUseCase(result: .failure(AnyError("Get external id failed")))
        mockUseCaseFactory.generateGetExternalIdUseCaseResult = mockUseCase
        waitUntil { done in
            self.instanceUnderTest.getExternalId() { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get external id failed"))
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
