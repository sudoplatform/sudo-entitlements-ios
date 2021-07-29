//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import AWSAppSync
import SudoLogging
import SudoOperations
import SudoApiClient
@testable import SudoEntitlements

class DefaultEntitlementsRepositoryTests: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: DefaultEntitlementsRepository!

    var mockOperationFactory: MockOperationFactory!

    var graphQLClient: SudoApiClient!

    // MARK: - Lifecycle

    override func setUp() {
        mockOperationFactory = MockOperationFactory()
        graphQLClient = MockAWSAppSyncClientGenerator.generateClient()
        instanceUnderTest = DefaultEntitlementsRepository(graphQLClient: graphQLClient, logger: .testLogger)
        instanceUnderTest.operationFactory = mockOperationFactory
    }

    // MARK: - Tests: Lifecycle

    func test_initializer() {
        let logger = Logger.testLogger
        let instanceUnderTest = DefaultEntitlementsRepository(graphQLClient: graphQLClient, logger: logger)
        XCTAssertTrue(instanceUnderTest.graphQLClient === graphQLClient)
        XCTAssertTrue(instanceUnderTest.logger === logger)
    }

    func test_reset() {
        let mockQueue = MockPlatformOperationQueue()
        instanceUnderTest.queue = mockQueue
        instanceUnderTest.reset()
        XCTAssertEqual(mockQueue.cancelAllOperationsCallCount, 1)
    }

    // MARK: - Tests: getEntitlements

    func test_getEntitlements_ConstructsOperation() {
        instanceUnderTest.queue.isSuspended = true
        instanceUnderTest.getEntitlements { _ in }
        XCTAssertEqual(instanceUnderTest.queue.operationCount, 1)
        guard let operation = instanceUnderTest.queue.operations.first(whereType: PlatformQueryOperation<GetEntitlementsQuery>.self) else {
            return XCTFail("Expected operation not found")
        }
        XCTAssertEqual(operation.cachePolicy, .remoteOnly)
    }

    func test_getEntitlements_RespectsOperationFailure() {
        mockOperationFactory.getEntitlementsOperation = MockGetEntitlementsQuery(error: AnyError("Get Failed"))
        waitUntil { done in
            self.instanceUnderTest.getEntitlements { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get Failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_getEntitlements_ReturnsNonNilOperationSuccessResult() {
        let outputEntitlements = GetEntitlementsQuery.Data.GetEntitlement(
            createdAtEpochMs: 1.0,
            updatedAtEpochMs: 1.0,
            version: 1,
            name: "TestName",
            description: nil,
            entitlements: []
        )
        let result = GetEntitlementsQuery.Data(getEntitlements: outputEntitlements)
        mockOperationFactory.getEntitlementsOperation = MockGetEntitlementsQuery(result: result)
        waitUntil { done in
            self.instanceUnderTest.getEntitlements { result in
                defer { done() }
                switch result {
                case let .success(Entitlements):
                    XCTAssertNotNil(Entitlements)
                    XCTAssertEqual(Entitlements!.name, "TestName")
                    XCTAssertEqual(Entitlements!.version, 1)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_getEntitlements_ReturnsNilOperationSuccessResult() {
        let result = GetEntitlementsQuery.Data(getEntitlements: nil)
        mockOperationFactory.getEntitlementsOperation = MockGetEntitlementsQuery(result: result)
        waitUntil { done in
            self.instanceUnderTest.getEntitlements { result in
                defer { done() }
                switch result {
                case let .success(Entitlements):
                    XCTAssertNil(Entitlements)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    // MARK: - Tests: getEntitlementsConsumption

    func test_getEntitlementsConsumption_ConstructsOperation() {
        instanceUnderTest.queue.isSuspended = true
        instanceUnderTest.getEntitlementsConsumption { _ in }
        XCTAssertEqual(instanceUnderTest.queue.operationCount, 1)
        guard let operation = instanceUnderTest.queue.operations.first(whereType: PlatformQueryOperation<GetEntitlementsConsumptionQuery>.self) else {
            return XCTFail("Expected operation not found")
        }
        XCTAssertEqual(operation.cachePolicy, .remoteOnly)
    }

    func test_getEntitlementsConsumption_RespectsOperationFailure() {
        mockOperationFactory.getEntitlementsConsumptionOperation =
            MockGetEntitlementsConsumptionQuery(error: AnyError("Get Failed"))
        waitUntil { done in
            self.instanceUnderTest.getEntitlementsConsumption { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get Failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    // MARK: - Tests: getExternalId

    func test_getExternalId_ConstructsOperation() {
        instanceUnderTest.queue.isSuspended = true
        instanceUnderTest.getExternalId { _ in }
        XCTAssertEqual(instanceUnderTest.queue.operationCount, 1)
        guard let operation = instanceUnderTest.queue.operations.first(whereType: PlatformQueryOperation<GetExternalIdQuery>.self) else {
            return XCTFail("Expected operation not found")
        }
        XCTAssertEqual(operation.cachePolicy, .remoteOnly)
    }

    func test_getExternalId_RespectsOperationFailure() {
        mockOperationFactory.getExternalIdOperation = MockGetExternalIdQuery(error: AnyError("Get External ID Failed"))
        waitUntil { done in
            self.instanceUnderTest.getExternalId { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get External ID Failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_getExternalId_ReturnsOperationSuccessResult() {
        let outputExternalId = "external-id"
        let result = GetExternalIdQuery.Data(getExternalId: outputExternalId)
        mockOperationFactory.getExternalIdOperation = MockGetExternalIdQuery(result: result)
        waitUntil { done in
            self.instanceUnderTest.getExternalId { result in
                defer { done() }
                switch result {
                case let .success(externalId):
                    XCTAssertEqual(externalId, outputExternalId)
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    // MARK: - Tests: redeemEntitlements

    func test_redeemEntitlements_ConstructsOperation() {
        instanceUnderTest.queue.isSuspended = true
        instanceUnderTest.redeemEntitlements { _ in }
        XCTAssertEqual(instanceUnderTest.queue.operationCount, 1)
        guard let operation = instanceUnderTest.queue.operations.first(whereType: PlatformMutationOperation<RedeemEntitlementsMutation>.self) else {
            return XCTFail("Expected operation not found")
        }
        XCTAssertEqual(operation.errors.count, 0)
    }

    func test_redeemEntitlements_RespectsOperationFailure() {
        mockOperationFactory.redeemEntitlementsOperation = MockRedeemEntitlementsOperation(error: AnyError("Get Failed"))
        waitUntil { done in
            self.instanceUnderTest.redeemEntitlements { result in
                defer { done() }
                switch result {
                case let .failure(error as AnyError):
                    XCTAssertEqual(error, AnyError("Get Failed"))
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }

    func test_redeemEntitlements_ReturnsOperationSuccessResult() {
        let outputEntitlement = RedeemEntitlementsMutation.Data.RedeemEntitlement.Entitlement(
            name: "EntitlementName",
            description: "EntitlementDescription",
            value: 1
        )
        let redeemEntitlement = RedeemEntitlementsMutation.Data.RedeemEntitlement(
            createdAtEpochMs: 2.0,
            updatedAtEpochMs: 4.0,
            version: 1,
            name: "RedeemedName",
            description: "RedeemedDescription",
            entitlements: [outputEntitlement]
        )
        let result = RedeemEntitlementsMutation.Data(redeemEntitlements: redeemEntitlement)
        mockOperationFactory.redeemEntitlementsOperation = MockRedeemEntitlementsOperation(result: result)
        waitUntil { done in
            self.instanceUnderTest.redeemEntitlements { result in
                defer { done() }
                let logger = Logger.testLogger
                logger.debug("\(result)")
                switch result {
                case let .success(Entitlements):
                    XCTAssertEqual(Entitlements.name, "RedeemedName")
                    XCTAssertEqual(Entitlements.description, "RedeemedDescription")
                    XCTAssertEqual(Entitlements.entitlements[0].name, "EntitlementName")
                default:
                    XCTFail("Unexpected result: \(result)")
                }
            }
        }
    }
}
