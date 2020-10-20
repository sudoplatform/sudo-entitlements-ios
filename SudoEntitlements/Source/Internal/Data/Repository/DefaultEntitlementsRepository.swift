//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoLogging
import SudoOperations

class DefaultEntitlementsRepository: EntitlementsRepository {

    /// App sync client for peforming operations against the entitlements service.
    var appSyncClient: AWSAppSyncClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    /// Utility factory class to generate mutation and query operations.
    var operationFactory = OperationFactory()

    /// Operation queue for enqueuing asynchronous tasks.
    var queue = PlatformOperationQueue()

    init(appSyncClient: AWSAppSyncClient, logger: Logger = .entitlementsSDKLogger) {
        self.appSyncClient = appSyncClient
        self.logger = logger
    }

    func reset() {
        queue.cancelAllOperations()
    }
    
    /// Get the users current set of entitlements
    func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>) {
        let query = GetEntitlementsQuery()
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
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
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
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
}
