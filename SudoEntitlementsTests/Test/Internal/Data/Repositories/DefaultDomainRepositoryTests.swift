//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import AWSAppSync
import SudoLogging
import SudoApiClient
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

    override func setUp() {
        entitlements = [
            Entitlement(
                name: "e.name",
                description: "e.description",
                value: 42
            )
        ]
        userEntitlements = UserEntitlements(version: 1.0, entitlements: entitlements)
        consumption = EntitlementConsumption(name: "testConsumption", consumer: nil, value: 10, consumed: 5, available: 5, firstConsumedAtEpochMs: 100.0, lastConsumedAtEpochMs: 200.0)
        entitlementsConsumption = EntitlementsConsumption(entitlements: userEntitlements, consumption: [consumption])

        entitlementsSet = EntitlementsSet(name: "entitlements", entitlements: entitlements, version: 1.0, created: Date(millisecondsSince1970: 1), updated: Date(millisecondsSince1970: 2))


        sudoApiClient = MockAWSAppSyncClientGenerator.generateClient()
        instanceUnderTest = DefaultEntitlementsRepository(graphQLClient: sudoApiClient, logger: .testLogger)
    }

    // MARK: - Tests: Lifecycle

    func test_initializer() {
        let logger = Logger.testLogger
        let instanceUnderTest = DefaultEntitlementsRepository(
            graphQLClient: sudoApiClient,
            logger: logger)
        XCTAssertTrue(instanceUnderTest.graphQLClient === sudoApiClient)
        XCTAssertTrue(instanceUnderTest.logger === logger)
    }

    // MARK: - Tests: getEntitlementsConsumption

    func test_getEntitlementsConsumption_ReturnsSuccessfully() async throws {
        sudoApiClient.fetchGetEntitlementsConsumptionResult = .success(entitlementsConsumption)

        let result = try await instanceUnderTest.getEntitlementsConsumption()

        XCTAssertEqual(result, entitlementsConsumption)

        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    func test_getEntitlementsConsumption_RespectsOperationFailure() async throws {
        sudoApiClient.fetchGetEntitlementsConsumptionResult = .failure(SudoEntitlementsError.accountLocked)
    
        do {
            let result = try await instanceUnderTest.getEntitlementsConsumption()
            XCTFail("Unexpected result: \(result)")
        }
        catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        }
        catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }

        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    // MARK: - Tests: getExternalId

    func test_getExternalId_ReturnsSuccessfully() async throws {
        sudoApiClient.fetchGetExternalIdResult = .success("external-id")
        let result = try await instanceUnderTest.getExternalId()
        XCTAssertEqual(result, "external-id")

        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    func test_getExternalId_RespectsOperationFailure() async throws  {
        sudoApiClient.fetchGetExternalIdResult = .failure(SudoEntitlementsError.accountLocked)
    
        do {
            let result = try await instanceUnderTest.getExternalId()
            XCTFail("Unexpected result: \(result)")
        }
        catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        }
        catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(sudoApiClient.fetchCallCount, 1)
        XCTAssertEqual(sudoApiClient.performCallCount, 0)
    }

    // MARK: - Tests: redeemEntitlements

    func test_redeemEntitlements_ReturnsSuccessfully() async throws {
        sudoApiClient.performRedeemEntitlementResult = .success(entitlementsSet)
        
        let result = try await instanceUnderTest.redeemEntitlements()
        
        XCTAssertEqual(result, entitlementsSet)

        XCTAssertEqual(sudoApiClient.performCallCount, 1)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 0)
    }

    func test_redeemEntitlements_RespectsOperationFailure() async throws {
        sudoApiClient.performRedeemEntitlementResult = .failure(SudoEntitlementsError.accountLocked)
        do {
            let result = try await instanceUnderTest.redeemEntitlements()
            XCTFail("Unexpected result: \(result)")
        }
        catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        }
        catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }

        XCTAssertEqual(sudoApiClient.performCallCount, 1)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 0)
    }

    // MARK: - Tests: consumeBooleanEntitlements

    func test_consumeBooleanEntitlements_ReturnsSuccessfully() async throws {
        sudoApiClient.performConsumeBooleanEntitlementsResult = .success(())
        try await instanceUnderTest.consumeBooleanEntitlements(entitlementNames: ["some-entitlement"])
        XCTAssertEqual(sudoApiClient.performCallCount, 1)
        XCTAssertEqual(sudoApiClient.fetchCallCount, 0)
    }

    func test_consumeBooleanEntitlements_RespectsOperationFailure() async throws {
        sudoApiClient.performConsumeBooleanEntitlementsResult = .failure(SudoEntitlementsError.accountLocked)
        do {
            try await instanceUnderTest.consumeBooleanEntitlements(entitlementNames: ["some-entitlement"])
            XCTFail("Unexpected succcess")
        }
        catch(let error as SudoEntitlementsError) {
            XCTAssertEqual(error, .accountLocked)
        }
        catch(let error) {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
