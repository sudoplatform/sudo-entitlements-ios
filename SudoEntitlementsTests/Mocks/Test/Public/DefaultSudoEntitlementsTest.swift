//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements

class DefaultSudoEntitlementsTest: BaseTestCase {

    // MARK: - Lifecycle

    var entitlements: [Entitlement]!
    var userEntitlements: UserEntitlements!
    var consumption: EntitlementConsumption!
    var entitlementsConsumption: EntitlementsConsumption!
    var entitlementsSet: EntitlementsSet!
    
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

        super.setUp()
        mockUserClient.isSignedInReturn = true


    }

    // MARK: - Tests

    func test_getEntitlementsConsumption_ReturnsSuccessfully() async throws  {
        let mockUseCase = MockGetEntitlementsConsumptionUseCase(result: .success(entitlementsConsumption))
        mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseResult = mockUseCase

        let result = try await instanceUnderTest.getEntitlementsConsumption()
        XCTAssertEqual(result, entitlementsConsumption)

        XCTAssertEqual(mockUseCaseFactory.generateConsumeBooleanEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_getExternalId_ReturnsSuccessfully() async throws  {
        let mockUseCase = MockGetExternalIdUseCase(result: .success("external-id"))
        mockUseCaseFactory.generateGetExternalIdUseCaseResult = mockUseCase

        let result = try await instanceUnderTest.getExternalId()

        XCTAssertEqual(result, "external-id")
        XCTAssertEqual(mockUseCaseFactory.generateConsumeBooleanEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_redeemEntitlements_ReturnsSuccessfully() async throws  {
        let mockUseCase = MockRedeemEntitlementsUseCase(result: .success(entitlementsSet))
        mockUseCaseFactory.generateRedeemEntitlementsUseCaseResult = mockUseCase

        let result = try await instanceUnderTest.redeemEntitlements()
        XCTAssertEqual(result, entitlementsSet)

        XCTAssertEqual(mockUseCaseFactory.generateConsumeBooleanEntitlementsUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 1)
    }

    func test_consumeBooleanEntitlements_ReturnsSuccessfully() async throws  {
        let mockUseCase = MockConsumeBooleanEntitlementsUseCase(result: .success(()))
        mockUseCaseFactory.generateConsumeBooleanEntitlementsUseCaseResult = mockUseCase

        try await instanceUnderTest.consumeBooleanEntitlements(entitlementNames: [])

        XCTAssertEqual(mockUseCaseFactory.generateConsumeBooleanEntitlementsUseCaseCount, 1)
        XCTAssertEqual(mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateGetExternalIdUseCaseCount, 0)
        XCTAssertEqual(mockUseCaseFactory.generateRedeemEntitlementsUseCaseCount, 0)
    }

    func test_getEntitlementsConsumption_RespectsUseCaseFailure() async throws  {
        let mockUseCase = MockGetEntitlementsConsumptionUseCase(result: .failure(AnyError("Get entitlements consumption failed")))
        mockUseCaseFactory.generateGetEntitlementsConsumptionUseCaseResult = mockUseCase

        do {
           let result = try await self.instanceUnderTest.getEntitlementsConsumption()
           XCTFail("Unexpected result: \(result)")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Get entitlements consumption failed"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_getExternalId_RespectsUseCaseFailure() async throws  {
        let mockUseCase = MockGetExternalIdUseCase(result: .failure(AnyError("Get external id failed")))
        mockUseCaseFactory.generateGetExternalIdUseCaseResult = mockUseCase
        
        do {
            let result = try await self.instanceUnderTest.getExternalId()
            XCTFail("Unexpected result: \(result)")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Get external id failed"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_redeemEntitlements_RespectsUseCaseFailure() async throws  {
        let mockUseCase = MockRedeemEntitlementsUseCase(result: .failure(AnyError("Redeem entitlements failed")))
        mockUseCaseFactory.generateRedeemEntitlementsUseCaseResult = mockUseCase
        
        do {
            let result = try await self.instanceUnderTest.redeemEntitlements()
            XCTFail("Unexpected result: \(result)")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Redeem entitlements failed"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_consumeBooleanEntitlements_RespectsUseCaseFailure() async throws  {
        let mockUseCase = MockConsumeBooleanEntitlementsUseCase(result: .failure(AnyError("Consume boolean entitlements failed")))
        mockUseCaseFactory.generateConsumeBooleanEntitlementsUseCaseResult = mockUseCase
        do {
            try await self.instanceUnderTest.consumeBooleanEntitlements(entitlementNames: [])
            XCTFail("Unexpected success")
        }
        catch (let error as AnyError) {
            XCTAssertEqual(error, AnyError("Consume boolean entitlements failed"))
        }
        catch (let error) {
            XCTFail("Unexpected error \(error)")
        }
    }
}
