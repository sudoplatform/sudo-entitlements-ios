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

    func test_execute_RespectsDomainFailure() async throws {
        mockRepository.getEntitlementsConsumptionResult = .failure(AnyError("Failed to get"))
        do {
            let result = try await self.instanceUnderTest.execute()
            XCTFail("Unexpected result: \(result)")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Failed to get"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }

        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 1)
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 0)
    }

    func test_execute_ReturnsSuccess() async throws {
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
        let result = try await self.instanceUnderTest.execute()
        XCTAssertNotNil(result)
        XCTAssertEqual(result.entitlements, userEntitlements)
        XCTAssertEqual(result.consumption, entitlementsConsumption.consumption)

        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 1)
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 0)
    }
}
