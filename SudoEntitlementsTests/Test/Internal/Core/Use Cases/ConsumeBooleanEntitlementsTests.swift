//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class ConsumeBooleanEntitlementsUseCaseTests: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: ConsumeBooleanEntitlementsUseCase!

    var mockRepository: MockEntitlementsRepository!

    // MARK: - Lifecycle

    override func setUp() {
        mockRepository = MockEntitlementsRepository()
        instanceUnderTest = ConsumeBooleanEntitlementsUseCase(repository: mockRepository)
    }

    // MARK: - Tests

    func test_initializer() {
        let instanceUnderTest = ConsumeBooleanEntitlementsUseCase(repository: mockRepository)
        XCTAssertTrue(instanceUnderTest.repository === mockRepository)
    }

    func test_execute_CallsCorrectRepositoryMethod() {
        instanceUnderTest.execute(entitlementNames: ["some-entitlement"]) { _ in }
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 1)
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 0)
        XCTAssertEqual(mockRepository.getEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
    }

    func test_execute_RespectsDomainFailure() {
        mockRepository.consumeBooleanEntitlementsResult = .failure(AnyError("Failed to get external id"))
        waitUntil { done in
            self.instanceUnderTest.execute(entitlementNames: ["some-entitlement"]) { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Failed to get external id"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_execute_ReturnsSuccess() {
        mockRepository.consumeBooleanEntitlementsResult = .success(())
        waitUntil { done in
            self.instanceUnderTest.execute(entitlementNames: ["some-entitlement"]) { result in
                defer { done() }
                switch result {
                case .success(()):
                    break
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
}
