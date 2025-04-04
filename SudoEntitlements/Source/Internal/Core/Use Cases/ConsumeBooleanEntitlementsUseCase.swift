//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Perform a mutation of the entitlements service to redeem the users set of entitlements
class ConsumeBooleanEntitlementsUseCase {

    let repository: EntitlementsRepository

    init(repository: EntitlementsRepository) {
        self.repository = repository
    }

    func execute(entitlementNames: [String]) async throws {
        try await repository.consumeBooleanEntitlements(entitlementNames: entitlementNames)
    }
}
