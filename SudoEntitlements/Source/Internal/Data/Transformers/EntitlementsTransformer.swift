//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Transformer for GraphQL types to output results of the SDK.
struct EntitlementsTransformer {

    func transform(_ result: GraphQL.GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption) -> EntitlementsConsumption {
        return EntitlementsConsumption(
            entitlements:UserEntitlements(
                version: result.entitlements.version,
                entitlementsSetName: result.entitlements.entitlementsSetName,
                entitlements: transform(result.entitlements.entitlements)),
            consumption:transform(result.consumption))
    }

    private func transform(_ items: [GraphQL.GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption.Entitlement.Entitlement]) -> [Entitlement] {
        return items.map {
            Entitlement(name: $0.name, description: $0.description, value: Int64($0.value))
        }
    }

    private func transform(_ items: [GraphQL.GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption.Consumption]) -> [EntitlementConsumption] {
        return items.map {
            EntitlementConsumption(
                name: $0.name,
                consumer: $0.consumer == nil ? nil : EntitlementConsumer(
                    id: $0.consumer!.id,
                    issuer: $0.consumer!.issuer),
                value: Int64($0.value),
                consumed: Int64($0.consumed),
                available: Int64($0.available),
                firstConsumedAtEpochMs: $0.firstConsumedAtEpochMs,
                lastConsumedAtEpochMs: $0.lastConsumedAtEpochMs
            )
        }
    }

    func transform(_ result: GraphQL.GetEntitlementsQuery.Data.GetEntitlement) -> EntitlementsSet {
        return EntitlementsSet(
            name: result.name,
            description: result.description,
            entitlements: transform(result.entitlements),
            version: result.version,
            created: Date(millisecondsSince1970: result.createdAtEpochMs),
            updated: Date(millisecondsSince1970: result.updatedAtEpochMs)
        )
    }

    private func transform(_ items: [GraphQL.GetEntitlementsQuery.Data.GetEntitlement.Entitlement]) -> [Entitlement] {
        return items.map {
            Entitlement(name: $0.name, description: $0.description, value: Int64($0.value))
        }
    }

    func transform(_ result: GraphQL.RedeemEntitlementsMutation.Data.RedeemEntitlement) -> EntitlementsSet {
        return EntitlementsSet(
            name: result.name,
            description: result.description,
            entitlements: transform(result.entitlements),
            version: result.version,
            created: Date(millisecondsSince1970: result.createdAtEpochMs),
            updated: Date(millisecondsSince1970: result.updatedAtEpochMs)
        )
    }

    private func transform(_ items: [GraphQL.RedeemEntitlementsMutation.Data.RedeemEntitlement.Entitlement]) -> [Entitlement] {
        return items.map {
            Entitlement(name: $0.name, description: $0.description, value: Int64($0.value))
        }
    }
}
