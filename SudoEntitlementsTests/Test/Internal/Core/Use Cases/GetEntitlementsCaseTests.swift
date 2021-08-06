//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class GetEntitlementsUseCaseTests: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: GetEntitlementsUseCase!

    var mockRepository: MockEntitlementsRepository!

    // MARK: - Lifecycle

    override func setUp() {
        mockRepository = MockEntitlementsRepository()
        instanceUnderTest = GetEntitlementsUseCase(repository: mockRepository)
    }

    // MARK: - Tests

    func test_initializer() {
        let instanceUnderTest = GetEntitlementsUseCase(repository: mockRepository)
        XCTAssertTrue(instanceUnderTest.repository === mockRepository)
    }

    func test_execute_CallsCorrectRepositoryMethod() {
        instanceUnderTest.execute { _ in }
        XCTAssertEqual(mockRepository.getEntitlementsCallCount, 1)
        XCTAssertEqual(mockRepository.getEntitlementsConsumptionCallCount, 0)
        XCTAssertEqual(mockRepository.consumeBooleanEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.redeemEntitlementsCallCount, 0)
        XCTAssertEqual(mockRepository.getExternalIdCallCount, 0)
    }

    func test_execute_RespectsDomainFailure() {
        mockRepository.getEntitlementsResult = .failure(AnyError("Failed to get"))
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
        let entitlementsSet = EntitlementsSet(
            name: "name",
            description: "description",
            entitlements: entitlements,
            version: 1,
            created: Date(millisecondsSince1970: 1),
            updated: Date(millisecondsSince1970: 1)
        )
        mockRepository.getEntitlementsResult = .success(entitlementsSet)
        waitUntil { done in
            self.instanceUnderTest.execute { result in
                defer { done() }
                switch result {
                case let .success(entities):
                    XCTAssertNotNil(entities)
                    XCTAssertEqual(entities!.description, "description")
                    XCTAssertEqual(entities!.entitlements, entitlements)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
    func test_execute_ReturnsNilSuccess() {
        mockRepository.getEntitlementsResult = .success(nil)
        waitUntil { done in
            self.instanceUnderTest.execute { result in
                defer { done() }
                switch result {
                case let .success(entities):
                    XCTAssertNil(entities)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
}
