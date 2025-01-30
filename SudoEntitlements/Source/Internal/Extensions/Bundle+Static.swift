//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

private final class BundleLocator {}

extension Bundle {
    /// To support consumers who need to consume the UI library via cocoapods as a static library we
    /// need to ensure that the bundle is loaded from the main bundle if possible.
    internal static var sdkBundle: Bundle {
        // Bundle.module isn't always correct during testing. Solution modified from
        // https://forums.swift.org/t/swift-5-3-swiftpm-resources-in-tests-uses-wrong-bundle-path/37051/49
        #if DEBUG
        if let moduleName = Bundle(for: BundleLocator.self).bundleIdentifier?.components(separatedBy: ".").last,
               let testBundlePath = ProcessInfo.processInfo.environment["XCTestBundlePath"],
               let testBundle = Bundle(path: testBundlePath),
               let resourceBundleURL = testBundle.url(forResource: "\(moduleName)_\(moduleName)", withExtension: "bundle"),
               let resourceBundle = Bundle(url: resourceBundleURL) {
                return resourceBundle
            }
        #endif
        return Bundle.module
    }

    private final class BundleLocator {}
}
