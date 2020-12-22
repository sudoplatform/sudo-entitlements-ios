//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations

///
/// Split a composite entitlements version in to its user entitlements version and entitlements set
/// version components.
///
/// - Parameter version:
///     Version from a UserEntitlements or EntitlementsSet
/// - Returns:
///     A tuple of the user entitlements version and entitlement set version.
/// - Throws `SudoPlatformError.invalidArgument`:
///     If the version is negative or has precision greater than `Constants.entitlementsSetVersionScalingFactor`
///     allows
///
public func splitUserEntitlementsVersion(version: Double) throws -> (Int,Int) {
    
    if (version < 0) {
        throw SudoPlatformError.invalidArgument(msg: "version negative")
    }

    let userEntitlementsVersion = lround(version)
    let entitlementsSetVersion = lround(version * Constants.entitlementsSetVersionScalingFactor)
     % Int(Constants.entitlementsSetVersionScalingFactor)
    
    let reconstructedVersion =
    Double(userEntitlementsVersion) + Double(entitlementsSetVersion)/Constants.entitlementsSetVersionScalingFactor
    if (reconstructedVersion != version) {
        throw SudoPlatformError.invalidArgument(msg: "version too precise")
    }
    
    return (userEntitlementsVersion, entitlementsSetVersion)
}
