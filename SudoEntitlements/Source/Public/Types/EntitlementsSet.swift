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
    public let name: String

    /// Human readable description of the set of entitlements.
    public let description: String?

    /// The set of entitlement values.
    public let entitlements: [Entitlement]

    /// The version number of this set of entitlements.
    public let version: Int

    /// When the set of entitlements was created.
    public let created: Date

    /// When the set of entitlements was last updated.
    public let updated: Date
    
    public init(name: String, description: String?, entitlements: [Entitlement], version: Int, created: Date, updated: Date) {
        self.name = name
        self.description = description
        self.entitlements = entitlements // TODO: make a defensive copy
        self.version = version
        self.created = created
        self.updated = updated
    }
}
