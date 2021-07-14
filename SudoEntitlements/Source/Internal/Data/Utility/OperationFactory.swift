//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoOperations
import SudoLogging
import SudoApiClient

class OperationFactory {

    func generateQueryOperation<Query: GraphQLQuery>(
        query: Query,
        graphQLClient: SudoApiClient,
        cachePolicy: CachePolicy = CachePolicy.remoteOnly,
        logger: Logger
    ) -> PlatformQueryOperation<Query> {
        return PlatformQueryOperation(
            graphQLClient: graphQLClient,
            serviceErrorTransformations: [SudoEntitlementsError.init(graphQLError:)],
            query: query,
            cachePolicy: cachePolicy.toSudoOperationsCachePolicy(),
            logger: logger)
    }

    func generateMutationOperation<Mutation: GraphQLMutation>(
        mutation: Mutation,
        optimisticUpdate: OptimisticResponseBlock? = nil,
        optimisticCleanup: OptimisticCleanupBlock? = nil,
        graphQLClient: SudoApiClient,
        logger: Logger
    ) -> PlatformMutationOperation<Mutation> {
        return PlatformMutationOperation(
            graphQLClient: graphQLClient,
            serviceErrorTransformations: [SudoEntitlementsError.init(graphQLError:)],
            mutation: mutation,
            optimisticUpdate: optimisticUpdate,
            optimisticCleanup: optimisticCleanup,
            logger: logger)
    }

}
