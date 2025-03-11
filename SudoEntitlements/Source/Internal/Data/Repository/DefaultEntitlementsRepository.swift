//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoApiClient

class DefaultEntitlementsRepository: EntitlementsRepository {

    // MARK: - Properties

    /// GraphQL client for performing operations against the entitlements service.
    var graphQLClient: SudoApiClient
    
    /// Utility for transforming GraphQL output entities to the public types defined in this SDK.
    let transformer = EntitlementsTransformer()

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    init(graphQLClient: SudoApiClient, logger: Logger = .entitlementsSDKLogger) {
        self.graphQLClient = graphQLClient
        self.logger = logger
    }

    // MARK: - Conformance: EntitlementsRepository

    func reset() {
        // no-op
    }
    
    /// Get the users current set of entitlements
    func getEntitlementsConsumption() async throws -> EntitlementsConsumption {
        do {
            let graphQLResult = try await graphQLClient.fetch(query: GraphQL.GetEntitlementsConsumptionQuery())
            return transformer.transform(graphQLResult.getEntitlementsConsumption)
        } catch {
            throw SudoEntitlementsError.fromApiOperationError(error: error)
        }
    }

    /// Get the users external ID
    func getExternalId() async throws -> String {
        do {
            let graphQLResult = try await graphQLClient.fetch(query: GraphQL.GetExternalIdQuery())
            return graphQLResult.getExternalId
        } catch {
            throw SudoEntitlementsError.fromApiOperationError(error: error)
        }
    }

    /// Redeem the entitlements the user is allowed
    func redeemEntitlements() async throws -> EntitlementsSet {
        do {
            let graphQLResult = try await graphQLClient.perform(mutation: GraphQL.RedeemEntitlementsMutation())
            return transformer.transform(graphQLResult.redeemEntitlements)
        } catch {
            throw SudoEntitlementsError.fromApiOperationError(error: error)
        }
    }

    /// Consume boolean entitlements
    func consumeBooleanEntitlements(entitlementNames: [String]) async throws {
        do {
            let mutation = GraphQL.ConsumeBooleanEntitlementsMutation(entitlementNames: entitlementNames)
            _ = try await graphQLClient.perform(mutation: mutation)
        } catch {
            throw SudoEntitlementsError.fromApiOperationError(error: error)
        }
    }
}
