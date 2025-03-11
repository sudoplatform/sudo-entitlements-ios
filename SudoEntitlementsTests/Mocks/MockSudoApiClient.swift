//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
@testable import SudoApiClient
@testable import SudoEntitlements

class MockSudoApiClient: SudoApiClient {

    var fetchCalled = false
    var fetchCallCount = 0
    var fetchParameters: (query: Any, Void)?
    var fetchParameterList: [(query: Any, Void)] = []
    var fetchResult: Result<Any, Error> = .failure(ApiOperationError.fatalError(description: "Not assigned"))

    func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
        fetchCalled = true
        fetchCallCount += 1
        fetchParameters = (query, ())
        fetchParameterList.append((query, ()))
        guard let data = try fetchResult.get() as? Query.Data else {
            throw ApiOperationError.fatalError(description: "Incorrect result type assigned")
        }
        return data
    }

    var performCalled = false
    var performCallCount = 0
    var performParameters: (mutation: Any, operationTimeout: Int?)?
    var performParameterList: [(mutation: Any, operationTimeout: Int?)] = []
    var performResult: Result<Any, Error> = .failure(ApiOperationError.fatalError(description: "Not assigned"))

    func perform<Mutation>(
        mutation: Mutation,
        operationTimeout: Int? = nil
    ) async throws -> Mutation.Data where Mutation : GraphQLMutation {
        performCalled = true
        performCallCount += 1
        performParameters = (mutation, operationTimeout)
        performParameterList.append((mutation, operationTimeout))
        guard let data = try performResult.get() as? Mutation.Data else {
            throw ApiOperationError.fatalError(description: "Incorrect result type assigned")
        }
        return data
    }

    var subscribeCalled = false
    var subscribeCallCount = 0
    var subscribeParameters: (subscription: Any, queue: DispatchQueue)?
    var subscribeStatusChangeResult: GraphQLClientConnectionState?
    var subscribeCompletionResult: Result<Void, Error>?
    var subscribeResult: Result<Any, Error>?
    var subscribeSubscription = GraphQLClientSubscriptionMock()

    func subscribe<Subscription: GraphQLSubscription>(
        subscription: Subscription,
        queue: DispatchQueue,
        statusChangeHandler: ((GraphQLClientConnectionState) -> Void)?,
        completionHandler: ((Result<Void, Error>) -> Void)?,
        resultHandler: @escaping (Result<Subscription.Data, Error>) -> Void
    ) -> GraphQLClientSubscription {
        subscribeCalled = true
        subscribeCallCount += 1
        subscribeParameters = (subscription, queue)
        if let status = subscribeStatusChangeResult {
            statusChangeHandler?(status)
        }
        if let completionResult = subscribeCompletionResult {
            completionHandler?(completionResult)
        }
        do {
            if let data = try subscribeResult?.get() as? Subscription.Data {
                resultHandler(.success(data))
            }
        } catch {
            resultHandler(.failure(error))
        }
        return subscribeSubscription
    }

    func getGraphQLClient() -> any GraphQLClient {
        fatalError("Not implemented")
    }
}

class GraphQLClientSubscriptionMock: GraphQLClientSubscription {

    var cancelCalled = false
    var cancelCallCount = 0

    func cancel() {
        cancelCalled = true
        cancelCallCount += 1
    }
}
