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

    func test_execute_CallsCorrectRepositoryMethod() {
        instanceUnderTest.execute { _ in }
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 1)
        XCTAssertEqual(mockRepository.getEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
    }

    func test_execute_RespectsDomainFailure() {
        mockRepository.getExternalIdResult = .failure(AnyError("Failed to get external id"))
        waitUntil { done in
            self.instanceUnderTest.execute { result in
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
        let externalId = "external-id"
        mockRepository.getExternalIdResult = .success(externalId)
        waitUntil { done in
            self.instanceUnderTest.execute { result in
                defer { done() }
                switch result {
                case let .success(actualExternalId):
                    XCTAssertEqual(actualExternalId, externalId)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
}
