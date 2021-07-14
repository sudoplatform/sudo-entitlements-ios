//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
// This is only testable to initialize GraphQLError for testing
@testable import AWSAppSync
@testable import SudoEntitlements
import SudoOperations

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
        XCTAssertEqual(error, .internalError("GraphQL error"))
    }

    func test_init_graphQL_UnsupportedReturnsInternalError() {
        let graphQLError = constructGraphQLErrorWithErrorType("foo-bar")
        let error = SudoEntitlementsError(graphQLError: graphQLError)
        XCTAssertEqual(error, .internalError("foo-bar - GraphQL error"))
    }

    // MARK: - Tests: SudoPlatformError Initializer

    func test_init_sudoPlatformError_ServiceError() {
        let sudoPlatformError: SudoPlatformError = .serviceError
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .serviceError)
    }

    func test_init_sudoPlatformError_PolicyFailed() {
        let sudoPlatformError: SudoPlatformError = .policyFailed
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .policyFailed)
    }

    func test_init_sudoPlatformError_InvalidTokenError() {
        let sudoPlatformError: SudoPlatformError = .invalidTokenError
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .invalidTokenError)
    }

    func test_init_sudoPlatformError_internalError_RespectsNil() {
        let sudoPlatformError: SudoPlatformError = .internalError(cause: nil)
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .internalError(nil))
    }

    func test_init_sudoPlatformError_internalError() {
        let sudoPlatformError: SudoPlatformError = .internalError(cause: "foobar")
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .internalError("foobar"))
    }

    func test_init_sudoPlatformError_invalidArgument_RespectsNil() {
        let sudoPlatformError: SudoPlatformError = .invalidArgument(msg: nil)
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .invalidArgument(nil))
    }

    func invalidArgument() {
        let sudoPlatformError: SudoPlatformError = .invalidArgument(msg: "foobar")
        let error = SudoEntitlementsError(platformError: sudoPlatformError)
        XCTAssertEqual(error, .invalidArgument("foobar"))
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

    func test_errorDescription_InternalError_RespectsNil() {
        let expectedDescription = "Internal Error"
        let errorDescription = SudoEntitlementsError.internalError(nil).errorDescription
        XCTAssertEqual(errorDescription, expectedDescription)
    }

    func test_errorDescription_InternalError_Cause() {
        let expectedDescription = "Foo Bar"
        let errorDescription = SudoEntitlementsError.internalError("Foo Bar").errorDescription
        XCTAssertEqual(errorDescription, expectedDescription)
    }

    func test_errorDescription_InvalidArgument_RespectsNil() {
        let expectedDescription = "Invalid argument"
        let errorDescription = SudoEntitlementsError.invalidArgument(nil).errorDescription
        XCTAssertEqual(errorDescription, expectedDescription)
    }

    func test_errorDescription_InternalArgument_Msg() {
        let expectedDescription = "Invalid argument: Foo Bar"
        let errorDescription = SudoEntitlementsError.invalidArgument("Foo Bar").errorDescription
        XCTAssertEqual(errorDescription, expectedDescription)
    }

}
