//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoUser
import SudoLogging

/// Generic type associated with API completion/closures. Generic type O is the expected output result in a success case.
public typealias ClientCompletion<O> = (Swift.Result<O, Error>) -> Void

/// Client used to interface with the Sudo Entitlements Platform service.
///
/// It is recommended to code to this interface, rather than the implementation class (`DefaultSudoEntitlementsClient`) as
/// the implementation class is only meant to be used for initializing an instance of the client.
public protocol SudoEntitlementsClient: AnyObject {

    // MARK: - Lifecycle
    
    /// Clear all locally cached data
    func reset() throws
    
    // MARK: - Queries

    /// Get the current set of entitlements and their consumption for the user
    /// - Returns:
    ///   - Success: The set of entitlements the user currently has and consumption information for
    ///     the user and its sub-resource consumers, if any
    ///   - Failure: `SudoEntitlementsError`
    func getEntitlementsConsumption(completion: @escaping ClientCompletion<EntitlementsConsumption>)

    /// Get the current set of entitlements for the user.
    ///
    /// Deprecated: Use `getEntitlementsConsumption` instead
    ///
    /// - Returns:
    ///   - Success: The set of entitlements the user currently has or nil if user has no entitlements
    ///   - Failure: `SudoEntitlementsError`.
    @available(*, deprecated)
    func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>)

    // MARK: - Mutations

    /// Redeem the entitlements for the user.
    /// - Returns:
    ///   - Success: The current set of entitlements the user has after the redemption has completed.
    ///   - Failure: `SudoEntitlementsError`.
    func redeemEntitlements(completion: @escaping ClientCompletion<EntitlementsSet>)
}
