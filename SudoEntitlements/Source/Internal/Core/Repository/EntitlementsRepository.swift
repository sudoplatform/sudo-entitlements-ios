//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

protocol EntitlementsRepository: class, Resetable {

    /// Get the users current set of entitlements and their consumption
    func getEntitlementsConsumption(completion: @escaping ClientCompletion<EntitlementsConsumption>)

    /// Get the users current set of entitlements
    func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>)

    /// Redeem the entitlements the user is allowed
    func redeemEntitlements(completion: @escaping ClientCompletion<EntitlementsSet>)
}
