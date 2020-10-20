//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit
import SudoUser

class MockSudoUserClient: SudoUserClient {

    var version: String = "version"

    func isRegistered() -> Bool {
        return true
    }

    func getSymmetricKeyId() throws -> String {
        return "dummySymmetricKey"
    }

    var mockSubject: String? = "dummyOwner"
    var getSubjectError: Error?

    func getSubject() throws -> String? {
        if let error = getSubjectError {
            throw error
        }

        return mockSubject
    }

    var getIdentityCallCount = 0
    var getIdentityIdResult: String? = "dummyIdentityId"

    func getIdentityId() -> String? {
        getIdentityCallCount += 1
        return getIdentityIdResult
    }

    func reset() throws {
        // Do Nothing.
    }

    func getDeviceCheckChallenge(deviceToken: Data, buildType: String, completion: @escaping (GetRegistrationChallengesResult) -> Void) throws {
        // Do Nothing.
    }

    func register(challenge: RegistrationChallenge, vendorId: UUID?, registrationId: String?, completion: @escaping (RegisterResult) -> Void) throws {
        // Do Nothing.
    }

    func registerWithAuthenticationProvider(
        authenticationProvider: AuthenticationProvider,
        registrationId: String?,
        completion: @escaping (RegisterResult) -> Void
    ) throws {
        // Do Nothing.
    }

    func deregister(completion: @escaping (DeregisterResult) -> Void) throws {
        // Do Nothing.
    }

    func signInWithKey(completion: @escaping (SignInResult) -> Void) throws {
        // Do Nothing.
    }

    func signInWithAuthenticationProvider(authenticationProvider: AuthenticationProvider, completion: @escaping (SignInResult) -> Void) throws {
        // Do Nothing.
    }

    func presentFederatedSignInUI(navigationController: UINavigationController, completion: @escaping (SignInResult) -> Void) throws {
        // Do Nothing.
    }

    func presentFederatedSignOutUI(navigationController: UINavigationController, completion: @escaping (ApiResult) -> Void) throws {
        // Do Nothing.
    }

    func getUserName() throws -> String? {
        return nil
    }

    func getIdToken() throws -> String? {
        return nil
    }

    func getAccessToken() throws -> String? {
        return nil
    }

    func getRefreshToken() throws -> String? {
        return nil
    }

    func getTokenExpiry() throws -> Date? {
        return nil
    }

    func encrypt(keyId: String, algorithm: SymmetricKeyEncryptionAlgorithm, data: Data) throws -> Data {
        return Data()
    }

    func decrypt(keyId: String, algorithm: SymmetricKeyEncryptionAlgorithm, data: Data) throws -> Data {
        return Data()
    }

    func clearAuthTokens() throws {
        // Do Nothing.
    }

    func globalSignOut(completion: @escaping (ApiResult) -> Void) throws {
        // Do Nothing.
    }

    func getCachedIdentityId() -> String? {
        return nil
    }

    func getUserClaim(name: String) throws -> Any? {
        return nil
    }

    func storeTokens(tokens: AuthenticationTokens) throws {
        // Do Nothing.
    }

    func refreshTokens(refreshToken: String, completion: @escaping (SignInResult) -> Void) throws {
        // Do Nothing.
    }

    func registerWithDeviceCheck(
        token: Data,
        buildType: String,
        vendorId: UUID?,
        registrationId: String?,
        completion: @escaping (RegisterResult) -> Void
    ) throws {
        // Do Nothing.
    }

    func isSignedIn() throws -> Bool {
        return true
    }

    func getSupportedRegistrationChallengeType() -> [ChallengeType] {
        return []
    }

    func registerSignInStatusObserver(id: String, observer: SignInStatusObserver) {
        // Do Nothing.
    }

    func deregisterSignInStatusObserver(id: String) {
        // Do Nothing.
    }
}
