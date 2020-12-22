//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoOperations
import SudoLogging

/// Perform a query of the entitlements service to get the current set of entitlements
class GetEntitlementsConsumptionUseCase {
    
    let repository: EntitlementsRepository

    init(repository: EntitlementsRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping ClientCompletion<EntitlementsConsumption>) {
        repository.getEntitlementsConsumption(completion: completion)
    }
}
