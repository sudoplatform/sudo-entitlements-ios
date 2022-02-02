//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
@testable import SudoEntitlements

class MockEntitlementsRepository: EntitlementsRepository, Resetable {

    var resetCallCount = 0

    func reset() {
        resetCallCount += 1
    }

    var getEntitlementsConsumptionCallCount = 0
    var getEntitlementsConsumptionResult: Result<EntitlementsConsumption, Error> = .failure(AnyError("Please add base result to `MockEntitlementsRepository.getEntitlementsConsumption`"))

    func getEntitlementsConsumption() async throws -> EntitlementsConsumption {
        getEntitlementsConsumptionCallCount += 1
        switch getEntitlementsConsumptionResult {
        case .failure(let error):
            throw error
        case .success(let result):
            return result
        }
    }

    var getExternalIdCallCount = 0
    var getExternalIdResult: Result<String, Error> = .failure(AnyError("Please add base result to `MockEntitlementsRepository.getExternalId`"))

    func getExternalId() async throws -> String {
        getExternalIdCallCount += 1
        switch getExternalIdResult {
        case .failure(let error):
            throw error
        case .success(let result):
            return result
        }
    }

    var redeemEntitlementsCallCount = 0
    var redeemEntitlementsResult: Result<EntitlementsSet, Error> = .failure(
        AnyError("Please add base result to `MockEntitlementsRepository.redeemEntitlements`")
    )

    func redeemEntitlements() async throws -> EntitlementsSet {
        redeemEntitlementsCallCount += 1
        switch redeemEntitlementsResult {
        case .failure(let error):
            throw error
        case .success(let result):
            return result
        }
    }

    var consumeBooleanEntitlementsCallCount = 0
    var consumeBooleanEntitlementsResult: Result<Void, Error> = .failure(
        AnyError("Please add base result to `MockEntitlementsRepository.consumeBooleanEntitlements`")
    )

    func consumeBooleanEntitlements(entitlementNames: [String]) async throws {
        consumeBooleanEntitlementsCallCount += 1
        switch consumeBooleanEntitlementsResult {
        case .failure(let error):
            throw error
        case .success:
            return
        }
    }
}
