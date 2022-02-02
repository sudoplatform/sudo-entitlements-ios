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

    func test_execute_CallsCorrectRepositoryMethod() async throws {
        mockRepository.consumeBooleanEntitlementsResult = .success(())
        try await instanceUnderTest.execute(entitlementNames: ["some-entitlement"])
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 1)
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 0)
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
    }

    func test_execute_RespectsDomainFailure() async throws {
        mockRepository.consumeBooleanEntitlementsResult = .failure(AnyError("Failed to get external id"))
        do {
            try await instanceUnderTest.execute(entitlementNames: ["some-entitlement"])
            XCTFail("Unexpected success")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Failed to get external id"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }
    }
}
