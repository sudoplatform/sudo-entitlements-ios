//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

// swiftlint:disable force_cast

import SudoOperations
import AWSAppSync
import SudoLogging
import SudoApiClient
@testable import SudoEntitlements

class MockOperationFactory: OperationFactory {

    var getEntitlementsOperation: MockQueryOperation<GetEntitlementsQuery>?
    
    var getEntitlementsConsumptionOperation: MockQueryOperation<GetEntitlementsConsumptionQuery>?

    var getExternalIdOperation: MockQueryOperation<GetExternalIdQuery>?

    var generateQueryLastProperties: (query: AnyObject, cachePolicy: SudoEntitlements.CachePolicy)?

    override func generateQueryOperation<Query>(
        query: Query,
        graphQLClient: SudoApiClient,
        cachePolicy: SudoEntitlements.CachePolicy,
        logger: Logger
    ) -> PlatformQueryOperation<Query> where Query: GraphQLQuery {
        generateQueryLastProperties = (query, cachePolicy)
        switch query.self {
        case is GetEntitlementsQuery:
            guard let op = getEntitlementsOperation else {
                return super.generateQueryOperation(query: query, graphQLClient: graphQLClient, cachePolicy: cachePolicy, logger: logger)
            }
            return op as! PlatformQueryOperation<Query>
        case is GetEntitlementsConsumptionQuery:
            guard let op = getEntitlementsConsumptionOperation else {
                return super.generateQueryOperation(query: query, graphQLClient: graphQLClient, cachePolicy: cachePolicy, logger: logger)
            }
            return op as! PlatformQueryOperation<Query>
        case is GetExternalIdQuery:
            guard let op = getExternalIdOperation else {
                return super.generateQueryOperation(query: query, graphQLClient: graphQLClient, cachePolicy: cachePolicy, logger: logger)
            }
            return op as! PlatformQueryOperation<Query>
        default:
            return super.generateQueryOperation(query: query, graphQLClient: graphQLClient, cachePolicy: cachePolicy, logger: logger)
        }
    }

    var redeemEntitlementsOperation: MockMutationOperation<RedeemEntitlementsMutation>?

    var generateMutationLastProperty: AnyObject?

    override func generateMutationOperation<Mutation>(
        mutation: Mutation,
        optimisticUpdate: OptimisticResponseBlock? = nil,
        optimisticCleanup: OptimisticCleanupBlock? = nil,
        graphQLClient: SudoApiClient,
        logger: Logger
    ) -> PlatformMutationOperation<Mutation> where Mutation: GraphQLMutation {
        generateMutationLastProperty = mutation
        switch mutation.self {
        case is RedeemEntitlementsMutation:
            guard let op = redeemEntitlementsOperation else {
                return super.generateMutationOperation(
                    mutation: mutation,
                    optimisticUpdate: optimisticUpdate,
                    optimisticCleanup: optimisticCleanup,
                    graphQLClient: graphQLClient,
                    logger: logger
                )
            }
            return op as! PlatformMutationOperation<Mutation>
        default:
            return super.generateMutationOperation(
                mutation: mutation,
                optimisticUpdate: optimisticUpdate,
                optimisticCleanup: optimisticCleanup,
                graphQLClient: graphQLClient,
                logger: logger
            )
        }
    }
}

class MockMutationOperation<Mutation: GraphQLMutation>: PlatformMutationOperation<Mutation> {

    var mockResult: Mutation.Data?
    override var result: Mutation.Data? {
        get {
            return mockResult
        }
        set {
            mockResult = newValue
        }
    }

    var error: Error?

    override func execute() {
        if let error = error {
            finishWithError(error)
        } else {
            finish()
        }
    }

}

class MockRedeemEntitlementsOperation: MockMutationOperation<RedeemEntitlementsMutation> {

    init(error: Error? = nil, result: RedeemEntitlementsMutation.Data? = nil) {
        let graphQLClient = MockAWSAppSyncClientGenerator.generateClient()
        let mutation = RedeemEntitlementsMutation()
        super.init(graphQLClient: graphQLClient, mutation: mutation, logger: .testLogger)
        self.error = error
        mockResult = result
    }

}

class MockQueryOperation<Query: GraphQLQuery>: PlatformQueryOperation<Query> {

    var mockResult: Query.Data?
    override var result: Query.Data? {
        get {
            return mockResult
        }
        set {
            mockResult = newValue
        }
    }

    var error: Error?

    override func execute() {
        if let error = error {
            finishWithError(error)
        } else {
            finish()
        }
    }

}

class MockGetEntitlementsQuery: MockQueryOperation<GetEntitlementsQuery> {

    init(error: Error? = nil, result: GetEntitlementsQuery.Data? = nil) {
        let graphQLClient = MockAWSAppSyncClientGenerator.generateClient()
        let query = GetEntitlementsQuery()
        super.init(graphQLClient: graphQLClient, query: query, cachePolicy: .remoteOnly, logger: .testLogger)
        self.error = error
        mockResult = result
    }
}

class MockGetEntitlementsConsumptionQuery: MockQueryOperation<GetEntitlementsConsumptionQuery> {

    init(error: Error? = nil, result: GetEntitlementsConsumptionQuery.Data? = nil) {
        let graphQLClient = MockAWSAppSyncClientGenerator.generateClient()
        let query = GetEntitlementsConsumptionQuery()
        super.init(graphQLClient: graphQLClient, query: query, cachePolicy: .remoteOnly, logger: .testLogger)
        self.error = error
        mockResult = result
    }
}

class MockGetExternalIdQuery: MockQueryOperation<GetExternalIdQuery> {

    init(error: Error? = nil, result: GetExternalIdQuery.Data? = nil) {
        let graphQLClient = MockAWSAppSyncClientGenerator.generateClient()
        let query = GetExternalIdQuery()
        super.init(graphQLClient: graphQLClient, query: query, cachePolicy: .remoteOnly, logger: .testLogger)
        self.error = error
        mockResult = result
    }
}
