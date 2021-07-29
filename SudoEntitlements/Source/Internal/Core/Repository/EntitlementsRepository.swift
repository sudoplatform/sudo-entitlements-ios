//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

protocol EntitlementsRepository: AnyObject, Resetable {

    /// Get the users current set of entitlements and their consumption
    func getEntitlementsConsumption(completion: @escaping ClientCompletion<EntitlementsConsumption>)

    /// Get the users current set of entitlements
    func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>)

    /// Get the users external ID
    func getExternalId(completion: @escaping ClientCompletion<String>)

    /// Redeem the entitlements the user is allowed
    func redeemEntitlements(completion: @escaping ClientCompletion<EntitlementsSet>)
}
