//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Transformer for GraphQL types to output results of the SDK.
struct EntitlementsTransformer {

    func transform(_ result: GetEntitlementsQuery.Data.GetEntitlement) -> EntitlementsSet {
        return EntitlementsSet(
            name: result.name,
            description: result.description,
            entitlements: transform(result.entitlements),
            version: result.version,
            created: Date(millisecondsSince1970: result.createdAtEpochMs),
            updated: Date(millisecondsSince1970: result.updatedAtEpochMs)
        )
    }

    private func transform(_ items: [GetEntitlementsQuery.Data.GetEntitlement.Entitlement]) -> [Entitlement] {
        return items.map {
            Entitlement(name: $0.name, description: $0.description, value: $0.value)
        }
    }

    func transform(_ result: RedeemEntitlementsMutation.Data.RedeemEntitlement) -> EntitlementsSet {
        return EntitlementsSet(
            name: result.name,
            description: result.description,
            entitlements: transform(result.entitlements),
            version: result.version,
            created: Date(millisecondsSince1970: result.createdAtEpochMs),
            updated: Date(millisecondsSince1970: result.updatedAtEpochMs)
        )
    }

    private func transform(_ items: [RedeemEntitlementsMutation.Data.RedeemEntitlement.Entitlement]) -> [Entitlement] {
        return items.map {
            Entitlement(name: $0.name, description: $0.description, value: $0.value)
        }
    }
}
