//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import SudoEntitlements
import SudoOperations

class VersionUtilitiesTest: XCTestCase {

    func test_splitUserEntitlementsVersion_shouldThrowIllegalArgumentForNegativeVersion() {
        XCTAssertThrowsError(try splitUserEntitlementsVersion(version:-1)) {
            error in
            if (!(error is SudoPlatformError)) {
                XCTFail("error is not a SudoPlatformError")
            }
            XCTAssertEqual(error as! SudoPlatformError, SudoPlatformError.invalidArgument(msg: "version negative"))}
    }
    
    func test_splitUserEntitlementsVersion_shouldThrowIllegalArgumentForTooPreciseVersion() {
        XCTAssertThrowsError(try splitUserEntitlementsVersion(version:1.000001)) {
            error in
            if (!(error is SudoPlatformError)) {
                XCTFail("error is not a SudoPlatformError")
            }
            XCTAssertEqual(error as! SudoPlatformError, SudoPlatformError.invalidArgument(msg: "version too precise"))}
    }

    func test_splitUserEntitlementsVersion_shouldSetEntitlementsSetVersionToZeroWithNoFraction() {
        let (userEntitlementsVersion, entitlementsSetVersion) = try! splitUserEntitlementsVersion(version:1)
        XCTAssertEqual(userEntitlementsVersion,1)
        XCTAssertEqual(entitlementsSetVersion,0)
    }

    func test_splitUserEntitlementsVersion_shouldSplitWithSingleDigitVersionElements() {
        let (userEntitlementsVersion, entitlementsSetVersion) = try! splitUserEntitlementsVersion(version:2.00001)
        XCTAssertEqual(userEntitlementsVersion,2)
        XCTAssertEqual(entitlementsSetVersion,1)
    }

    func test_splitUserEntitlementsVersion_shouldSplitWithDoubleDigitVersionElements() {
        let (userEntitlementsVersion, entitlementsSetVersion) = try! splitUserEntitlementsVersion(version:20.0001)
        XCTAssertEqual(userEntitlementsVersion,20)
        XCTAssertEqual(entitlementsSetVersion,10)
    }
}
