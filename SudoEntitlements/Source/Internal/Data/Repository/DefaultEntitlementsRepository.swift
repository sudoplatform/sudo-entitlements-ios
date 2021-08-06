//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoLogging
import SudoOperations
import SudoApiClient

class DefaultEntitlementsRepository: EntitlementsRepository {

    /// GraphQL client for peforming operations against the entitlements service.
    var graphQLClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    /// Utility factory class to generate mutation and query operations.
    var operationFactory = OperationFactory()

    /// Operation queue for enqueuing asynchronous tasks.
    var queue = PlatformOperationQueue()

    init(graphQLClient: SudoApiClient, logger: Logger = .entitlementsSDKLogger) {
        self.graphQLClient = graphQLClient
        self.logger = logger
    }

    func reset() {
        queue.cancelAllOperations()
    }
    
    /// Get the users current set of entitlements
    func getEntitlementsConsumption(completion: @escaping ClientCompletion<EntitlementsConsumption>) {
        let query = GetEntitlementsConsumptionQuery()
        let operation = operationFactory.generateQueryOperation(query: query, graphQLClient: graphQLClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                if error is ApiOperationError {
                    completion(.failure(SudoEntitlementsError.fromApiOperationError(error: error)))
                } else {
                    completion(.failure(error))
                }
                return
            }
            guard let graphQLResult = operation.result?.getEntitlementsConsumption else {
                completion(.failure(SudoEntitlementsError.serviceError))
                return
            }
            let transformer = EntitlementsTransformer()
            let result = transformer.transform(graphQLResult)
            completion(.success(result))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    /// Get the users external ID
    func getExternalId(completion: @escaping ClientCompletion<String>) {
        let query = GetExternalIdQuery()
        let operation = operationFactory.generateQueryOperation(query: query, graphQLClient: graphQLClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                if error is ApiOperationError {
                    completion(.failure(SudoEntitlementsError.fromApiOperationError(error: error)))
                } else {
                    completion(.failure(error))
                }
                return
            }
            guard let graphQLResult = operation.result?.getExternalId else {
                completion(.failure(SudoEntitlementsError.serviceError))
                return
            }
            completion(.success(graphQLResult))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    /// Get the users current set of entitlements
    func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>) {
        let query = GetEntitlementsQuery()
        let operation = operationFactory.generateQueryOperation(query: query, graphQLClient: graphQLClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                if error is ApiOperationError {
                    completion(.failure(SudoEntitlementsError.fromApiOperationError(error: error)))
                } else {
                    completion(.failure(error))
                }
                return
            }
            guard let graphQLResult = operation.result?.getEntitlements else {
                completion(.success(nil))
                return
            }
            let transformer = EntitlementsTransformer()
            let result = transformer.transform(graphQLResult)
            completion(.success(result))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    /// Redeem the entitlements the user is allowed
    func redeemEntitlements(completion: @escaping ClientCompletion<EntitlementsSet>) {
        let mutation = RedeemEntitlementsMutation()
        let operation = operationFactory.generateMutationOperation(mutation: mutation, graphQLClient: graphQLClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                if error is ApiOperationError {
                    completion(.failure(SudoEntitlementsError.fromApiOperationError(error: error)))
                } else {
                    completion(.failure(error))
                }
                return
            }
            guard let graphQLResult = operation.result?.redeemEntitlements else {
                completion(.failure(SudoEntitlementsError.serviceError))
                return
            }
            let transformer = EntitlementsTransformer()
            let result = transformer.transform(graphQLResult)
            completion(.success(result))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    /// Consume boolean entitlements
    func consumeBooleanEntitlements(entitlementNames: [String], completion: @escaping ClientCompletion<Void>) {
        let mutation = ConsumeBooleanEntitlementsMutation(entitlementNames: entitlementNames)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, graphQLClient: graphQLClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { _, errors in
            if let error = errors.first {
                if error is ApiOperationError {
                    completion(.failure(SudoEntitlementsError.fromApiOperationError(error: error)))
                } else {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(()))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }
}
