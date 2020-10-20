//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

///
/// A representation of a single entitlement possessed by a user.
///
public struct Entitlement: Equatable {
    
    /// Name of the entitlement.
    public let name: String

    /// Human readable description of the entitlement.
    public let description: String?

    /// The quantity of the entitlement.
    public let value: Int

    public init(name: String, description: String?, value: Int) {
        self.name = name
        self.description = description
        self.value = value
    }
}
