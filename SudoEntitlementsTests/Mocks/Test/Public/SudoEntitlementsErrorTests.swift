//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import XCTest
@testable import SudoEntitlements
import SudoApiClient

class SudoEntitlementsErrorTests: XCTestCase {

    func constructGraphQLErrorWithErrorType(_ type: String?, _ message: String = "GraphQL error") -> GraphQLError {
        guard let type = type else {
            return GraphQLError(message: message)
        }
        let obj: [String: JSONValue] = [
            "errorType": .string(type),
            "message": .string(message)
        ]
        return GraphQLError(message: message, extensions: obj)
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

    func test_fromApiOperationError_noExternalId() {
        let graphQLError = constructGraphQLErrorWithErrorType("sudoplatform.entitlements.NoExternalIdError")

        let error = SudoEntitlementsError.fromApiOperationError(error: ApiOperationError.graphQLError(cause: graphQLError))
        XCTAssertEqual(error, .noExternalId)
    }

    func test_fromApiOperationError_noBillingGroup() {
        let graphQLError = constructGraphQLErrorWithErrorType("sudoplatform.entitlements.NoBillingGroupError")

        let error = SudoEntitlementsError.fromApiOperationError(error: ApiOperationError.graphQLError(cause: graphQLError))
        XCTAssertEqual(error, .noBillingGroup)
    }

    func test_fromApiOperationError_entitlementsSetNotFound() {
        let graphQLError = constructGraphQLErrorWithErrorType("sudoplatform.entitlements.EntitlementsSetNotFoundError")

        let error = SudoEntitlementsError.fromApiOperationError(error: ApiOperationError.graphQLError(cause: graphQLError))
        XCTAssertEqual(error, .entitlementsSetNotFound)
    }

    func test_fromApiOperationError_entitlementsSequenceNotFound() {
        let graphQLError = constructGraphQLErrorWithErrorType("sudoplatform.entitlements.EntitlementsSequenceNotFoundError")

        let error = SudoEntitlementsError.fromApiOperationError(error: ApiOperationError.graphQLError(cause: graphQLError))
        XCTAssertEqual(error, .entitlementsSequenceNotFound)
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

    func test_errorDescription_NoExternalId() {
        let L10Ndescription = L10n.Entitlements.Errors.noExternalId
        let errorDescription = SudoEntitlementsError.noExternalId.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_NoBillingGroup() {
        let L10Ndescription = L10n.Entitlements.Errors.noBillingGroup
        let errorDescription = SudoEntitlementsError.noBillingGroup.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_EntitlementsSetNotFound() {
        let L10Ndescription = L10n.Entitlements.Errors.entitlementsSetNotFound
        let errorDescription = SudoEntitlementsError.entitlementsSetNotFound.errorDescription
        XCTAssertEqual(errorDescription, L10Ndescription)
    }

    func test_errorDescription_EntitlementsSequenceNotFound() {
        let L10Ndescription = L10n.Entitlements.Errors.entitlementsSequenceNotFound
        let errorDescription = SudoEntitlementsError.entitlementsSequenceNotFound.errorDescription
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
