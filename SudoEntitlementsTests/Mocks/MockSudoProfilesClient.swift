//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoProfiles
@testable import SudoEntitlements

class MockSudoProfilesClient: SudoProfilesClient {

    var getOwnershipProofCallCount = 0
    var getOwnershipProofLastProperties: (sudo: Sudo, audience: String)?
    var getOwnershipProofResult: GetOwnershipProofResult = .failure(cause: AnyError("Please add base result to `MockSudoProfilesClient.getOwnershipProof`"))
    var getOwnershipProofThrownError: Error?

    func getOwnershipProof(sudo: Sudo, audience: String, completion: @escaping (GetOwnershipProofResult) -> Void) throws {
        getOwnershipProofCallCount += 1
        getOwnershipProofLastProperties = (sudo, audience)
        if let error = getOwnershipProofThrownError {
            throw error
        }
        completion(getOwnershipProofResult)
    }

    func subscribe(id: String, subscriber: SudoSubscriber) throws {
    }

    func createSudo(sudo: Sudo, completion: @escaping (CreateSudoResult) -> Void) throws {
    }

    func updateSudo(sudo: Sudo, completion: @escaping (UpdateSudoResult) -> Void) throws {
    }

    func deleteSudo(sudo: Sudo, completion: @escaping (ApiResult) -> Void) throws {
    }

    func listSudos(option: ListOption, completion: @escaping (ListSudosResult) -> Void) throws {
    }

    func getOutstandingRequestsCount() -> Int {
        return 0
    }

    func reset() throws {
    }

    func subscribe(id: String, changeType: SudoChangeType, subscriber: SudoSubscriber) throws {
    }

    func unsubscribe(id: String, changeType: SudoChangeType) {
    }

    func unsubscribeAll() {
    }

    func redeem(token: String, type: String, completion: @escaping (RedeemResult) -> Void) throws {
    }

}
