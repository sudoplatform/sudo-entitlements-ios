//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
// This is only testable to initialize GraphQLError for testing
@testable import AWSAppSync
@testable import SudoEntitlements
import SudoApiClient

class SudoEntitlementsErrorTests: XCTestCase {

    func constructGraphQLErrorWithErrorType(_ type: String?, _ message: String = "GraphQL error") -> GraphQLError {
        guard let type = type else {
            return GraphQLError(["message":message])
        }
        let obj: [String: Any] = [
            "errorType": type,
            "message": message
        ]
        return GraphQLError(obj)
    }
    
    // MARK: - Tests: GraphQL Initializer

    func test_init_graphQL_NoErrorTypeReturnsInternalError() {
        let graphQLError = constructGraphQLErrorWithErrorType(nil)
        let error = SudoEntitlementsError(graphQLError: graphQLError)
        XCTAssertEqual(error, .graphQLError(cause: graphQLError))
    }

    func test_init_graphQL_UnsupportedReturnsInternalError() {
        let graphQLError = constructGraphQLErrorWithErrorType("foo-bar")
        let error = SudoEntitlementsError(graphQLError: graphQLError)
        XCTAssertEqual(error, .graphQLError(cause: graphQLError))
    }

    // MARK: - Tests: fromApiOperationError

    func test_fromApiOperationError_ServiceError() {
        let apiOperationError: ApiOperationError = .serviceError
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .serviceError)
    }

    func test_fromApiOperationError_NotSignedIn() {
        let apiOperationError: ApiOperationError = .notSignedIn
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .notSignedIn)
    }

    func test_fromApiOperationError_fatalError() {
        let apiOperationError: ApiOperationError = .fatalError(description: "fatal error")
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .fatalError("fatal error"))
    }

    func test_fromApiOperationError_invalidRequest() {
        let apiOperationError: ApiOperationError = .invalidRequest
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .invalidRequest)
    }

    func test_fromApiOperationError_invalidArgument() {
        let apiOperationError: ApiOperationError = .invalidArgument
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .invalidArgument)
    }

    func test_fromApiOperationError_insufficientEntitlements() {
        let apiOperationError: ApiOperationError = .insufficientEntitlements
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .insufficientEntitlements)
    }

    func test_fromApiOperationError_accountLocked() {
        let apiOperationError: ApiOperationError = .accountLocked
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .accountLocked)
    }

    func test_fromApiOperationError_limitExceeded() {
        let apiOperationError: ApiOperationError = .limitExceeded
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .limitExceeded)
    }

    func test_fromApiOperationError_notAuthorized() {
        let apiOperationError: ApiOperationError = .notAuthorized
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .notAuthorized)
    }

    func test_fromApiOperationError_rateLimitExceeded() {
        let apiOperationError: ApiOperationError = .rateLimitExceeded
        let error = SudoEntitlementsError.fromApiOperationError(error: apiOperationError)
        XCTAssertEqual(error, .rateLimitExceeded)
    }

    func test_fromApiOperationError_ambiguousEntitlements() {
        let ambiguousEntitlementsErrorGraphQL = constructGraphQLErrorWithErrorType("sudoplatform.entitlements.AmbiguousEntitlementsError")

        let error = SudoEntitlementsError.fromApiOperationError(error: ApiOperationError.graphQLError(cause: ambiguousEntitlementsErrorGraphQL))
        XCTAssertEqual(error, .ambiguousEntitlements)
    }

    // MARK: - Tests: ErrorDescription

    func test_errorDescription_InvalidConfig() {
        let L10Ndescription = L10n.Entitlements.Errors.invalidConfig
        let errorDescription = SudoEntitlementsError.invalidConfig.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_NotSignedIn() {
        let L10Ndescription = L10n.Entitlements.Errors.notSignedIn
        let errorDescription = SudoEntitlementsError.notSignedIn.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_ServiceError() {
        let L10Ndescription = L10n.Entitlements.Errors.serviceError
        let errorDescription = SudoEntitlementsError.serviceError.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_PolicyFailed() {
        let L10Ndescription = L10n.Entitlements.Errors.policyFailed
        let errorDescription = SudoEntitlementsError.policyFailed.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_InvalidTokenError() {
        let L10Ndescription = L10n.Entitlements.Errors.invalidTokenError
        let errorDescription = SudoEntitlementsError.invalidTokenError.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_FatalError_Cause() {
        let expectedDescription = "Unexpected fatal error occurred: Foo Bar"
        let errorDescription = SudoEntitlementsError.fatalError("Foo Bar").errorDescription
        XCTAssertEqual(errorDescription, expectedDescription)
    }

    func test_errorDescription_InvalidArgument() {
        let expectedDescription = "Invalid argument"
        let errorDescription = SudoEntitlementsError.invalidArgument.errorDescription
        XCTAssertEqual(errorDescription, expectedDescription)
    }
}
