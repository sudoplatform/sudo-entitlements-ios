//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import SudoLogging
import SudoApiClient
import SudoUser
@testable import SudoEntitlements

class DefaultEntitlementsRepositoryTests: XCTestCase {

    // MARK: - Properties

    var instanceUnderTest: DefaultEntitlementsRepository!
    var sudoApiClient: MockSudoApiClient!
    var entitlements: [Entitlement]!
    var userEntitlements: UserEntitlements!
    var consumption: EntitlementConsumption!
    var entitlementsConsumption: EntitlementsConsumption!
    var entitlementsSet: EntitlementsSet!
    
    // MARK: - Lifecycle

    override func setUp() async throws {
        entitlements = [
            Entitlement(
                name: "e.name",
                description: "e.description",
                value: 42
            )
        ]
        userEntitlements = UserEntitlements(version: 1.0, entitlements: entitlements)
        consumption = EntitlementConsumption(
            name: "testConsumption",
            consumer: nil,
            value: 10,
            consumed: 5,
            available: 5,
            firstConsumedAtEpochMs: 100.0,
            lastConsumedAtEpochMs: 200.0
        )
        entitlementsConsumption = EntitlementsConsumption(entitlements: userEntitlements, consumption: [consumption])
        entitlementsSet = EntitlementsSet(
            name: "entitlements",
            entitlements: entitlements,
            version: 1.0,
            created: Date(millisecondsSince1970: 1),
            updated: Date(millisecondsSince1970: 2)
        )
        sudoApiClient = MockSudoApiClient()
        instanceUnderTest = DefaultEntitlementsRepository(graphQLClient: sudoApiClient, logger: .testLogger)
    }

    // MARK: - Tests: Lifecycle

    func test_initializer() {
        let logger = Logger.testLogger
        let instanceUnderTest = DefaultEntitlementsRepository(graphQLClient: sudoApiClient, logger: logger)
        XCTAssertTrue(instanceUnderTest.graphQLClient === sudoApiClient)
        XCTAssertTrue(instanceUnderTest.logger === logger)
    }

    // MARK: - Tests: getEntitlementsConsumption

    func test_getEntitlementsConsumption_ReturnsSuccessfully() async throws {
        // given
        let data = entitlementsConsumptionToGraphQL(entitlementsConsumption)
        sudoApiClient.fetchResult = .success(data)
        // when
        let result = try await instanceUnderTest.getEntitlementsConsumption()
        // then
        XCTAssertEqual(result, entitlementsConsumption)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    func test_getEntitlementsConsumption_RespectsOperationFailure() async throws {
        // given
        sudoApiClient.fetchResult = .failure(ApiOperationError.accountLocked)
        // when
        do {
            let result = try await instanceUnderTest.getEntitlementsConsumption()
            // then
            XCTFail("Unexpected result: \(result)")
        } catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        } catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    // MARK: - Tests: getExternalId

    func test_getExternalId_ReturnsSuccessfully() async throws {
        // given
        let data = GraphQL.GetExternalIdQuery.Data(getExternalId: "external-id")
        sudoApiClient.fetchResult = .success(data)
        // when
        let result = try await instanceUnderTest.getExternalId()
        // then
        XCTAssertEqual(result, "external-id")
        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    func test_getExternalId_RespectsOperationFailure() async throws  {
        // given
        sudoApiClient.fetchResult = .failure(ApiOperationError.accountLocked)
        // when
        do {
            let result = try await instanceUnderTest.getExternalId()
            XCTFail("Unexpected result: \(result)")
            // then
        } catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        } catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    // MARK: - Tests: redeemEntitlements

    func test_redeemEntitlements_ReturnsSuccessfully() async throws {
        // given
        let data = entitlementsSetToGraphQL(entitlementsSet)
        sudoApiClient.performResult = .success(data)
        // when
        let result = try await instanceUnderTest.redeemEntitlements()
        // then
        XCTAssertEqual(result, entitlementsSet)
        XCTAssertEqual(sudoApiClient.performCallCount, 1)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 0)
    }

    func test_redeemEntitlements_RespectsOperationFailure() async throws {
        // given
        sudoApiClient.performResult = .failure(ApiOperationError.accountLocked)
        // when
        do {
            let result = try await instanceUnderTest.redeemEntitlements()
            // then
            XCTFail("Unexpected result: \(result)")
        } catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        } catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(sudoApiClient.performCallCount, 1)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 0)
    }

    // MARK: - Tests: consumeBooleanEntitlements

    func test_consumeBooleanEntitlements_ReturnsSuccessfully() async throws {
        // given
        let data = GraphQL.ConsumeBooleanEntitlementsMutation.Data(consumeBooleanEntitlements: true)
        sudoApiClient.performResult = .success(data)
        // when
        try await instanceUnderTest.consumeBooleanEntitlements(entitlementNames: ["some-entitlement"])
        // then
        XCTAssertEqual(sudoApiClient.performCallCount, 1)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 0)
    }

    func test_consumeBooleanEntitlements_RespectsOperationFailure() async throws {
        // given
        sudoApiClient.performResult = .failure(ApiOperationError.accountLocked)
        // when
        do {
            try await instanceUnderTest.consumeBooleanEntitlements(entitlementNames: ["some-entitlement"])
            // then
            XCTFail("Unexpected succcess")
        } catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        } catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // MARK: - Helpers

    func entitlementsConsumptionToGraphQL(
        _ entitlementsConsumption: EntitlementsConsumption
    ) -> GraphQL.GetEntitlementsConsumptionQuery.Data {
        typealias Query = GraphQL.GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption
        let entitlements: [Query.Entitlement.Entitlement] = entitlementsConsumption.entitlements.entitlements.map {
            .init(name: $0.name, description: $0.description, value: Double($0.value))
        }
        let consumptionEntitlements: Query.Entitlement = .init(
            version: entitlementsConsumption.entitlements.version,
            entitlementsSetName: entitlementsConsumption.entitlements.entitlementsSetName,
            entitlements: entitlements
        )
        let consumption: [Query.Consumption] = entitlementsConsumption.consumption.map {
            .init(
                name: $0.name,
                consumer: $0.consumer != nil ? .init(id: $0.consumer!.id, issuer: $0.consumer!.issuer) : nil,
                value: Double($0.value),
                consumed: Double($0.consumed),
                available: Double($0.available),
                firstConsumedAtEpochMs: $0.firstConsumedAtEpochMs,
                lastConsumedAtEpochMs: $0.lastConsumedAtEpochMs
            )
        }
        return GraphQL.GetEntitlementsConsumptionQuery.Data(
            getEntitlementsConsumption: .init(entitlements: consumptionEntitlements, consumption: consumption)
        )
    }

    func entitlementsSetToGraphQL(_ entitlementsSet: EntitlementsSet) -> GraphQL.RedeemEntitlementsMutation.Data {
        let entitlements: [GraphQL.RedeemEntitlementsMutation.Data.RedeemEntitlement.Entitlement] = entitlementsSet.entitlements.map {
            .init(
                name: $0.name,
                description: $0.description,
                value: Double($0.value)
            )
        }
        return GraphQL.RedeemEntitlementsMutation.Data(
            redeemEntitlements: .init(
                createdAtEpochMs: entitlementsSet.created.timeIntervalSince1970 * 1000,
                updatedAtEpochMs: entitlementsSet.updated.timeIntervalSince1970 * 1000,
                version: entitlementsSet.version,
                name: entitlementsSet.name,
                description: entitlementsSet.description,
                entitlements: entitlements
            )
        )
    }
}
