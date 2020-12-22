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
    case accountLockedError
    case decodingError
    case environmentError
    case identityInsufficient
    case identityNotVerified
    case insufficientEntitlementsError
    case internalError(_ cause: String?)
    case invalidArgument(_ msg: String?)
    case invalidTokenError
    case noEntitlementsError
    case policyFailed
    case serviceError
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
        case .accountLockedError:
            self = .accountLockedError
        case .decodingError:
            self = .decodingError
        case .environmentError:
            self = .environmentError
        case .identityInsufficient:
            self = .identityInsufficient
        case .identityNotVerified:
            self = .identityNotVerified
        case let .internalError(cause):
            self = .internalError(cause)
        case .insufficientEntitlementsError:
            self = .insufficientEntitlementsError
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
        case .unknownTimezone:
            self = .unknownTimezone
        }
    }

    public var errorDescription: String? {
        switch self {
        case .accountLockedError:
            return L10n.Entitlements.Errors.accountLockedError
        case .ambiguousEntitlements:
            return L10n.Entitlements.Errors.ambiguousEntitlementsError
        case .decodingError:
            return L10n.Entitlements.Errors.decodingError
        case .environmentError:
            return L10n.Entitlements.Errors.environmentError
        case .identityInsufficient:
            return L10n.Entitlements.Errors.identityInsufficient
        case .identityNotVerified:
            return L10n.Entitlements.Errors.identityNotVerified
        case .insufficientEntitlementsError:
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
        case .unknownTimezone:
            return L10n.Entitlements.Errors.unknownTimezone
        }
    }
}

