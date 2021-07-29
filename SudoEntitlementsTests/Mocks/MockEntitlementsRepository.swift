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

    func getEntitlementsConsumption(completion: @escaping ClientCompletion<EntitlementsConsumption>) {
        getEntitlementsConsumptionCallCount += 1
        completion(getEntitlementsConsumptionResult)
    }

    var getExternalIdCallCount = 0
    var getExternalIdResult: Result<String, Error> = .failure(AnyError("Please add base result to `MockEntitlementsRepository.getExternalId`"))

    func getExternalId(completion: @escaping ClientCompletion<String>) {
        getExternalIdCallCount += 1
        completion(getExternalIdResult)
    }

    var getEntitlementsCallCount = 0
    var getEntitlementsResult: Result<EntitlementsSet?, Error> = .failure(AnyError("Please add base result to `MockEntitlementsRepository.getEntitlements`"))

    func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>) {
        getEntitlementsCallCount += 1
        completion(getEntitlementsResult)
    }

    var redeemEntitlementsCallCount = 0
    var redeemEntitlementsResult: Result<EntitlementsSet, Error> = .failure(
        AnyError("Please add base result to `MockEntitlementsRepository.redeemEntitlements`")
    )

    func redeemEntitlements(completion: @escaping ClientCompletion<EntitlementsSet>) {
        redeemEntitlementsCallCount += 1
        completion(redeemEntitlementsResult)
    }
}
