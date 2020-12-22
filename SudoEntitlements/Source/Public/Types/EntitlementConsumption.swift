//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

///
/// A representation of the consumption of a particular entitlement
///
public struct EntitlementConsumption: Equatable {
    
    // MARK: - Properties
    
    /// Name of the consumed entitlement.
    public var name: String

    /// Consumer of the entitlement. If present this indicates the sub-user level resource
    /// responsible for consumption of the entitlement. If not present, the entitlement is
    /// consumed directly by the user.
    public var consumer: EntitlementConsumer?

    /// The maximum amount of the entitlement that can be consumed by the consumer
    public var value: Int

    /// The amount of the entitlement that has been consumed
    public var consumed: Int

    /// The amount of the entitlement that is yet to be consumed. Provided for convenience.
    /// `available` + `consumed` always equals `value`
    public var available: Int

    // MARK: - Lifecycle
    
    public init(name: String, consumer: EntitlementConsumer? = nil, value: Int, consumed: Int, available: Int) {
        self.name = name
        self.consumer = consumer == nil ? nil : EntitlementConsumer(consumer!)
        self.value = value
        self.consumed = consumed
        self.available = available
    }

    public init(_ original: EntitlementConsumption) {
        self.name = original.name
        self.consumer = original.consumer == nil ? nil :  EntitlementConsumer(original.consumer!)
        self.value = original.value
        self.consumed = original.consumed
        self.available = original.available
    }
}
