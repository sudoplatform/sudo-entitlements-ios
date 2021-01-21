//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class GetEntitlementsConsumptionUseCaseTests: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: GetEntitlementsConsumptionUseCase!

    var mockRepository: MockEntitlementsRepository!

    // MARK: - Lifecycle

    override func setUp() {
        mockRepository = MockEntitlementsRepository()
        instanceUnderTest = GetEntitlementsConsumptionUseCase(repository: mockRepository)
    }

    // MARK: - Tests

    func test_initializer() {
        let instanceUnderTest = GetEntitlementsConsumptionUseCase(repository: mockRepository)
        XCTAssertTrue(instanceUnderTest.repository === mockRepository)
    }

    func test_execute_CallsCorrectRepositoryMethod() {
        instanceUnderTest.execute { _ in }
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 1)
        XCTAssertEqual(mockRepository.getEntitlementsCallCount, 0)
    }

    func test_execute_RespectsDomainFailure() {
        mockRepository.getEntitlementsConsumptionResult = .failure(AnyError("Failed to get"))
        waitUntil { done in
            self.instanceUnderTest.execute { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Failed to get"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_execute_ReturnsNonNillSuccess() {
        let entitlements = [
            Entitlement(
                name: "e.name",
                description: "e.description",
                value: 42
            )
        ]
        let userEntitlements = UserEntitlements(version: 1.0, entitlements: entitlements)
        let consumption = EntitlementConsumption(name: "testConsumption", consumer: nil, value: 10, consumed: 5, available: 5, firstConsumedAtEpochMs: 100.0, lastConsumedAtEpochMs: 200.0)
        let entitlementsConsumption = EntitlementsConsumption(entitlements: userEntitlements, consumption: [consumption])
        mockRepository.getEntitlementsConsumptionResult = .success(entitlementsConsumption)
        waitUntil { done in
            self.instanceUnderTest.execute { result in
                defer { done() }
                switch result {
                case let .success(entity):
                    XCTAssertNotNil(entity)
                    XCTAssertEqual(entity.entitlements, userEntitlements)
                    XCTAssertEqual(entity.consumption, entitlementsConsumption.consumption)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
}
