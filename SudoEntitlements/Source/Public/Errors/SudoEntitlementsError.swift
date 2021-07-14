//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import SudoApiClient
import AWSAppSync

/// Errors that occur in SudoEntitlements.
public enum SudoEntitlementsError: Error, Equatable, LocalizedError {

    // MARK: - Client

    /// Configuration supplied to `DefaultSudoEntitlementsClient` is invalid.
    case invalidConfig
    /// User is not signed in.
    case notSignedIn

    /// The configuration related to Entitlements Service is not found in the provided configuration file
    /// This may indicate that the Entitlemetns Service is not deployed into your runtime instance or the
    /// configuration file that you are using is invalid..
    case entitlementsServiceConfigNotFound

    /// Indicates that the input to the API was invalid.
    case invalidInput

    /// Indicates the requested operation failed because the user account is locked.
    case accountLocked

    /// Indicates that the request operation failed due to authorization error. This maybe due to the authentication
    /// token being invalid or other security controls that prevent the user from accessing the API.
    case notAuthorized

    /// Indicates API call  failed due to it exceeding some limits imposed for the API. For example, this error
    /// can occur if the vault size was too big.
    case limitExceeded

    /// Indicates that the user does not have sufficient entitlements to perform the requested operation.
    case insufficientEntitlements

    /// Indicates the version of the vault that is getting updated does not match the current version of the vault stored
    /// in the backend. The caller should retrieve the current version of the vault and reconcile the difference.
    case versionMismatch

    /// Indicates that an internal server error caused the operation to fail. The error is possibly transient and
    /// retrying at a later time may cause the operation to complete successfully
    case serviceError

    /// Indicates that the request failed due to connectivity, availability or access error.
    case requestFailed(response: HTTPURLResponse?, cause: Error?)

    /// Indicates that there were too many attempts at sending API requests within a short period of time.
    case rateLimitExceeded

    /// Indicates that a GraphQL error was returned by the backend.
    case graphQLError(description: String)

    /// Indicates that a fatal error occurred. This could be due to coding error, out-of-memory condition or other
    /// conditions that is beyond control of `SudoSecureVaultClient` implementation.
    case fatalError(description: String)

    // MARK: - SudoPlatformError

    /// This section contains wrapped erros from `SudoPlatformError`.
    case ambiguousEntitlements
    case internalError(_ cause: String?)
    case invalidArgument(_ msg: String?)
    case invalidTokenError
    case noEntitlementsError
    case policyFailed

    public static func == (lhs: SudoEntitlementsError, rhs: SudoEntitlementsError) -> Bool {
        switch (lhs, rhs) {
        case (.requestFailed(let lhsResponse, let lhsCause), requestFailed(let rhsResponse, let rhsCause)):
            if let lhsResponse = lhsResponse, let rhsResponse = rhsResponse {
                return lhsResponse.statusCode == rhsResponse.statusCode
            }
            return type(of: lhsCause) == type(of: rhsCause)
        case (.invalidConfig, .invalidConfig),
             (.notSignedIn, .notSignedIn),
             (.accountLocked, .accountLocked),
             (.notAuthorized, .notAuthorized),
             (.limitExceeded, .limitExceeded),
             (.insufficientEntitlements, .insufficientEntitlements),
             (.versionMismatch, .versionMismatch),
             (.serviceError, .serviceError),
             (.rateLimitExceeded, .rateLimitExceeded),
             (.graphQLError, .graphQLError),
             (.fatalError, .fatalError),
             (.policyFailed, .policyFailed),
             (.invalidTokenError, .invalidTokenError),
             (.ambiguousEntitlements, ambiguousEntitlements),
             (.internalError, internalError),
             (.noEntitlementsError, noEntitlementsError),
             (.entitlementsServiceConfigNotFound, entitlementsServiceConfigNotFound),
             (.invalidArgument, .invalidArgument):
            return true
        default:
            return false
        }
    }

    // MARK: - Lifecycle

    /// Initialize a `SudoEntitlementsError` from a `GraphQLError`.
    ///
    /// If the GraphQLError is unsupported, `nil` will be returned instead.
    init(graphQLError error: GraphQLError) {
        guard let errorType = error["errorType"] as? String else {
            let sudoPlatformError = SudoPlatformError(error)
            self = SudoEntitlementsError(platformError:sudoPlatformError)
            return
        }
        switch errorType {
        case "sudoplatform.entitlements.AmbiguousEntitlementsError":
            self = .ambiguousEntitlements
        default:
            let sudoPlatformError = SudoPlatformError(error)
            self = SudoEntitlementsError(platformError:sudoPlatformError)
        }
    }

    /// Initialize a `SudoEntitlementsError` from a `SudoPlatformError`.
    init(platformError error: SudoPlatformError) {
        switch error {
        case let .internalError(cause):
            self = .internalError(cause)
        case .invalidArgument(let msg):
            self = .invalidArgument(msg)
        case .invalidTokenError:
            self = .invalidTokenError
        case .noEntitlementsError:
            self = .noEntitlementsError
        case .policyFailed:
            self = .policyFailed
        case .serviceError:
            self = .serviceError
        default:
            self = .fatalError(description: "Unexpected platform error: \(error)")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .accountLocked:
            return L10n.Entitlements.Errors.accountLockedError
        case .ambiguousEntitlements:
            return L10n.Entitlements.Errors.ambiguousEntitlementsError
        case .insufficientEntitlements:
            return L10n.Entitlements.Errors.insufficientEntitlementsError
        case let .internalError(cause):
            return cause ?? "Internal Error"
        case .invalidArgument(let msg):
            // Breaks all localization rules but good enough for here
            return msg != nil
                ? L10n.Entitlements.Errors.invalidArgument + ": \(msg!)"
                : L10n.Entitlements.Errors.invalidArgument
        case .invalidConfig:
            return L10n.Entitlements.Errors.invalidConfig
        case .invalidTokenError:
            return L10n.Entitlements.Errors.invalidTokenError
        case .noEntitlementsError:
            return L10n.Entitlements.Errors.noEntitlementsError
        case .notSignedIn:
            return L10n.Entitlements.Errors.notSignedIn
        case .policyFailed:
            return L10n.Entitlements.Errors.policyFailed
        case .serviceError:
            return L10n.Entitlements.Errors.serviceError
        case .entitlementsServiceConfigNotFound:
            return L10n.Entitlements.Errors.entitlementsServiceConfigNotFound
        case .invalidInput:
            return L10n.Entitlements.Errors.invalidInput
        case .notAuthorized:
            return L10n.Entitlements.Errors.notAuthorized
        case .limitExceeded:
            return L10n.Entitlements.Errors.limitExceeded
        case .versionMismatch:
            return L10n.Entitlements.Errors.versionMismatch
        case .requestFailed:
            return L10n.Entitlements.Errors.requestFailed
        case .rateLimitExceeded:
            return L10n.Entitlements.Errors.rateLimitExceeded
        case .graphQLError:
            return L10n.Entitlements.Errors.graphQLError
        case .fatalError:
            return L10n.Entitlements.Errors.fatalError
        }
    }

    static func fromApiOperationError(error: Error) -> SudoEntitlementsError {
        // Check if APIOperationERror or SudoPlatformError
        switch error {
        case ApiOperationError.accountLocked:
            return .accountLocked
        case ApiOperationError.notSignedIn:
            return .notSignedIn
        case ApiOperationError.notAuthorized:
            return .notAuthorized
        case ApiOperationError.limitExceeded:
            return .limitExceeded
        case ApiOperationError.insufficientEntitlements:
            return .insufficientEntitlements
        case ApiOperationError.serviceError:
            return .serviceError
        case ApiOperationError.versionMismatch:
            return .versionMismatch
        case ApiOperationError.invalidRequest:
            return .invalidInput
        case ApiOperationError.rateLimitExceeded:
            return .rateLimitExceeded
        case ApiOperationError.graphQLError(let cause):
            return SudoEntitlementsError(graphQLError: cause)
        case ApiOperationError.requestFailed(let response, let cause):
            return .requestFailed(response: response, cause: cause)
        default:
            return .fatalError(description: "Unexpected API operation error: \(error)")
        }
    }
}

