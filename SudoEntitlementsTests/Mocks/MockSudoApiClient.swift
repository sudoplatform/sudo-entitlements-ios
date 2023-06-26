//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
@testable import SudoApiClient
@testable import AWSAppSync
import SudoEntitlements

class MockSudoApiClient: SudoApiClient {
    
    var fetchCallCount = 0
    var fetchGetEntitlementsConsumptionResult: Result<EntitlementsConsumption> = .failure(SudoEntitlementsError.fatalError("Please add base result to `MockSudoApiClient.fetchGetEntitlementsConsumptionResult`"))
    
    var fetchGetExternalIdResult: Result<String> = .failure(SudoEntitlementsError.fatalError("Please add base result to `MockSudoApiClient.fetchGetExternalIdResult`"))

    func entitlementsConsumptionToGraphQL(_ entitlementsConsumption: EntitlementsConsumption) -> GetEntitlementsConsumptionQuery.Data {

        let entitlements: [GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption.Entitlement.Entitlement] =
        entitlementsConsumption.entitlements.entitlements.map { .init(name: $0.name,
                description: $0.description,
                value: $0.value)
            }

        let consumptionEntitlements: GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption.Entitlement = .init(
                version: entitlementsConsumption.entitlements.version,
                entitlementsSetName: entitlementsConsumption.entitlements.entitlementsSetName,
                entitlements: entitlements)

        let consumption:[GetEntitlementsConsumptionQuery.Data.GetEntitlementsConsumption.Consumption] = entitlementsConsumption.consumption.map { .init(
            consumer: $0.consumer != nil ? .init(id: $0.consumer!.id, issuer: $0.consumer!.issuer) : nil,
            name: $0.name,
            value: $0.value,
            consumed: $0.consumed,
            available: $0.available,
            firstConsumedAtEpochMs: $0.firstConsumedAtEpochMs,
            lastConsumedAtEpochMs: $0.lastConsumedAtEpochMs)
        }
        
        
        return GetEntitlementsConsumptionQuery.Data(getEntitlementsConsumption: .init(
            entitlements: consumptionEntitlements,
            consumption: consumption))
    }
    func entitlementsSetToGraphQL(_ entitlementsSet: EntitlementsSet) -> RedeemEntitlementsMutation.Data {

        let entitlements:[RedeemEntitlementsMutation.Data.RedeemEntitlement.Entitlement] = entitlementsSet.entitlements.map {
                .init(
                    name: $0.name,
                    description: $0.description,
                    value: $0.value)
            }
        
        return RedeemEntitlementsMutation.Data(redeemEntitlements: .init(
            createdAtEpochMs: entitlementsSet.created.timeIntervalSince1970 * 1000,
            updatedAtEpochMs: entitlementsSet.updated.timeIntervalSince1970 * 1000,
            version: entitlementsSet.version,
            name: entitlementsSet.name,
            description: entitlementsSet.description,
            entitlements: entitlements))
    }

    override func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: AWSAppSync.CachePolicy = .returnCacheDataElseFetch,
        queue: DispatchQueue = DispatchQueue.main
    ) async throws -> (result: GraphQLResult<Query.Data>?, error: Error?) {
        fetchCallCount += 1
        if (query is GetEntitlementsConsumptionQuery) {
            switch (fetchGetEntitlementsConsumptionResult) {
            case .success(let result):
                return (
                    result: GraphQLResult<Query.Data>(
                        data: (entitlementsConsumptionToGraphQL(result) as! Query.Data),
                        errors: [],
                        source: .server,
                        dependentKeys: []),
                    error: nil)
            case .failure(let error):
                return (result: nil, error: errorToApiOperationError(error))
            }
        }
        else if (query is GetExternalIdQuery) {
            switch (fetchGetExternalIdResult) {
            case .success(let result):
                return (
                    result: GraphQLResult<Query.Data>(
                        data: (GetExternalIdQuery.Data(getExternalId: result) as! Query.Data),
                        errors: [],
                        source: .server,
                        dependentKeys: []),
                    error: nil)
            case .failure(let error):
                return (result: nil, error: errorToApiOperationError(error))
            }
        }
        else {
            throw AnyError("Unkown mutation \(query)")
        }
    }
    
    var performCallCount = 0
    var performRedeemEntitlementResult: Result<EntitlementsSet> = .failure(SudoEntitlementsError.fatalError("Please add base result to `MockSudoApiClient.performRedeemEntitlementResult`"))
    var performConsumeBooleanEntitlementsResult: Result<Void> =
        .failure(SudoEntitlementsError.fatalError("Please add base result to `MockSudoApiClient.performConsumeBooleanEntitlementsResult`"))

    override func perform<Mutation: GraphQLMutation>(
        mutation: Mutation,
        queue: DispatchQueue = .main,
        optimisticUpdate: OptimisticResponseBlock? = nil,
        conflictResolutionBlock: MutationConflictHandler<Mutation>? = nil,
        operationTimeout: Int? = nil
    ) async throws -> (result: GraphQLResult<Mutation.Data>?, error: Error?) {
        performCallCount += 1

        if (mutation is RedeemEntitlementsMutation) {
            switch (performRedeemEntitlementResult) {
            case .success(let result):
                return (
                    result: GraphQLResult<Mutation.Data>(
                        data: (entitlementsSetToGraphQL(result) as! Mutation.Data),
                        errors: [],
                        source: .server,
                        dependentKeys: []),
                    error: nil)
            case .failure(let error):
                return (result: nil, error: errorToApiOperationError(error))
            }
        }
        else if (mutation is ConsumeBooleanEntitlementsMutation) {
            switch (performConsumeBooleanEntitlementsResult) {
            case .success:
                return (
                    result: GraphQLResult<Mutation.Data>(
                        data: nil,
                        errors: [],
                        source: .server,
                        dependentKeys: []),
                    error: nil)
            case .failure(let error):
                return (result: nil, error: errorToApiOperationError(error))
            }
        }
        else {
            throw AnyError("Unkown mutation \(mutation)")
        }
    }
    
    func errorToApiOperationError(_ error: Error?) -> ApiOperationError {
        
        var props: [String:String] = [:]
        
        let sudoEntitlementsError = error as? SudoEntitlementsError
        if (sudoEntitlementsError != nil) {
            switch (sudoEntitlementsError) {
            case .accountLocked:
                props["errorType"] = "sudoplatform.AccountLockedError"
                props["message"] = props["errorType"]
            case .serviceError:
                props["errorType"] = "sudoplatform.ServiceError"
                props["message"] = props["errorType"]
            case .ambiguousEntitlements:
                props["errorType"] = "sudoplatform.entitlements.AmbiguousEntitlementsError"
                props["message"] = props["errorType"]
            case .insufficientEntitlements:
                props["errorType"] = "sudoplatform.InsufficientEntitlementsError"
                props["message"] = props["errorType"]
            case .noEntitlements:
                props["errorType"] = "sudoplatform.NoEntitlementsError"
                props["message"] = props["errorType"]
            default:
                props["message"] = "\(error!)"
            }
        
        }
        else if (error != nil) {
            props["message"] = "\(error!)"
        }
        else {
            props["message"] = "<no error>"
        }

        return ApiOperationError.fromGraphQLError(error: GraphQLError(props))
    }
}
