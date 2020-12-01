//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

///
/// A representation of a set of entitlements possessed by a user.
///
public struct EntitlementsSet: Equatable {
    
    /// MARK: - Properties
    
    /// Name of the set of entitlements. This will often be a few words separated by dots like an internet domain.
    public var name: String

    /// Human readable description of the set of entitlements.
    public var description: String?

    /// The set of entitlement values.
    public var entitlements: [Entitlement]

    /// The version number of this set of entitlements.
    public var version: Int

    /// When the set of entitlements was created.
    public var created: Date

    /// When the set of entitlements was last updated.
    public var updated: Date

    /// MARK: - Lifecycle
    
    public init(name: String, description: String? = nil, entitlements: [Entitlement], version: Int, created: Date, updated: Date) {
        self.name = name
        self.description = description
        self.entitlements = entitlements // TODO: make a defensive copy
        self.version = version
        self.created = created
        self.updated = updated
    }
}
