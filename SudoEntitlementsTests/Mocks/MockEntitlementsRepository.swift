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
