//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class GetExternalIdUseCaseTests: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: GetExternalIdUseCase!

    var mockRepository: MockEntitlementsRepository!

    // MARK: - Lifecycle

    override func setUp() {
        mockRepository = MockEntitlementsRepository()
        instanceUnderTest = GetExternalIdUseCase(repository: mockRepository)
    }

    // MARK: - Tests

    func test_initializer() {
        let instanceUnderTest = GetExternalIdUseCase(repository: mockRepository)
        XCTAssertTrue(instanceUnderTest.repository === mockRepository)
    }

    func test_execute_ReturnsSuccess() async throws {
        mockRepository.getExternalIdResult = .success("external-id")
        let result = try await instanceUnderTest.execute()
        XCTAssertEqual(result, "external-id")
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 1)
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
    }

    func test_execute_RespectsDomainFailure() async throws {
        mockRepository.getExternalIdResult = .failure(AnyError("Failed to get external id"))
        do {
            let result = try await instanceUnderTest.execute()
            XCTFail("Unexpected result: \(result)")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Failed to get external id"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 1)
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
    }
}
