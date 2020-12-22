//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit
import SudoUser

class MockSudoUserClient: SudoUserClient {
    func registerWithDeviceCheck(token: Data, buildType: String, vendorId: UUID?, registrationId: String?, completion: @escaping (Result<String, Error>) -> Void) throws {
        // Do nothing
    }
    
    func refreshTokens(refreshToken: String, completion: @escaping (Result<AuthenticationTokens, Error>) -> Void) throws {
        // Do nothing
    }
    
    func globalSignOut(completion: @escaping (Result<Void, Error>) -> Void) throws {
        // Do nothing
    }
    
    func register(challenge: RegistrationChallenge, vendorId: UUID?, registrationId: String?, completion: @escaping (Result<String, Error>) -> Void) throws {
        // Do nothing
    }
    
    func registerWithAuthenticationProvider(authenticationProvider: AuthenticationProvider, registrationId: String?, completion: @escaping (Result<String, Error>) -> Void) throws {
        // Do nothing
    }
    
    func deregister(completion: @escaping (Result<String, Error>) -> Void) throws {
        // Do nothing
    }
    
    func signInWithKey(completion: @escaping (Result<AuthenticationTokens, Error>) -> Void) throws {
        // Do nothing
    }
    
    func signInWithAuthenticationProvider(authenticationProvider: AuthenticationProvider, completion: @escaping (Result<AuthenticationTokens, Error>) -> Void) throws {
        // Do nothing
    }
    
    func presentFederatedSignInUI(navigationController: UINavigationController, completion: @escaping (Result<AuthenticationTokens, Error>) -> Void) throws {
        // Do nothing
    }
    
    func presentFederatedSignOutUI(navigationController: UINavigationController, completion: @escaping (Result<Void, Error>) -> Void) throws {
        // Do nothing
    }
    
    func processFederatedSignInTokens(url: URL) throws -> Bool {
        return false
    }
    
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

    func getCachedIdentityId() -> String? {
        return nil
    }

    func getUserClaim(name: String) throws -> Any? {
        return nil
    }

    func storeTokens(tokens: AuthenticationTokens) throws {
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

    func processFederatedSignInTokens(url: URL) throws {
        // Do nothing
    }

    func getRefreshTokenExpiry() throws -> Date? {
        return nil
    }
}
