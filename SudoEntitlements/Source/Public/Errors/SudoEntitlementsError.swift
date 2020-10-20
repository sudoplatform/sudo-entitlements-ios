//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import AWSAppSync

/// Errors that occur in SudoEntitlements.
public enum SudoEntitlementsError: Error, Equatable, LocalizedError {

    // MARK: - Client

    /// Configuration supplied to `DefaultSudoEntitlementsClient` is invalid.
    case invalidConfig
    /// User is not signed in.
    case notSignedIn
    case ambiguousEntitlements

    // MARK: - SudoPlatformError

    /**
      * This section contains wrapped erros from `SudoPlatformError`.
     */
    case serviceError
    case decodingError
    case environmentError
    case policyFailed
    case invalidTokenError
    case accountLockedError
    case identityInsufficient
    case identityNotVerified
    case internalError(_ cause: String?)
    case invalidArgument(_ msg: String?)
    case unknownTimezone

    // MARK: - Lifecycle

    /// Initialize a `SudoEntitlementsError` from a `GraphQLError`.
    ///
    /// If the GraphQLError is unsupported, `nil` will be returned instead.
    init?(graphQLError error: GraphQLError) {
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
        case .serviceError:
            self = .serviceError
        case .decodingError:
            self = .decodingError
        case .environmentError:
            self = .environmentError
        case .policyFailed:
            self = .policyFailed
        case .invalidTokenError:
            self = .invalidTokenError
        case .accountLockedError:
            self = .accountLockedError
        case .identityInsufficient:
            self = .identityInsufficient
        case .identityNotVerified:
            self = .identityNotVerified
        case let .internalError(cause):
            self = .internalError(cause)
        case .unknownTimezone:
            self = .unknownTimezone
        case .invalidArgument(let msg):
            self = .invalidArgument(msg)
        }
    }

    public var errorDescription: String? {
        switch self {
        case .invalidConfig:
            return L10n.Entitlements.Errors.invalidConfig
        case .notSignedIn:
            return L10n.Entitlements.Errors.notSignedIn
        case .serviceError:
            return L10n.Entitlements.Errors.serviceError
        case .decodingError:
            return L10n.Entitlements.Errors.decodingError
        case .environmentError:
            return L10n.Entitlements.Errors.environmentError
        case .policyFailed:
            return L10n.Entitlements.Errors.policyFailed
        case .invalidTokenError:
            return L10n.Entitlements.Errors.invalidTokenError
        case .accountLockedError:
            return L10n.Entitlements.Errors.accountLockedError
        case .identityInsufficient:
            return L10n.Entitlements.Errors.identityInsufficient
        case .identityNotVerified:
            return L10n.Entitlements.Errors.identityNotVerified
        case .ambiguousEntitlements:
            return L10n.Entitlements.Errors.ambiguousEntitlementsError
        case let .internalError(cause):
            return cause ?? "Internal Error"
        case .unknownTimezone:
            return L10n.Entitlements.Errors.unknownTimezone
        case .invalidArgument(let msg):
            // Breaks all localization rules but good enough for here
            return msg != nil
                ? L10n.Entitlements.Errors.invalidArgument + ": \(msg!)"
                : L10n.Entitlements.Errors.invalidArgument
        }
    }
}

