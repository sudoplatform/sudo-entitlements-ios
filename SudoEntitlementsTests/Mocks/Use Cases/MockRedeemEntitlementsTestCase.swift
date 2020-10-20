//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

@testable import SudoEntitlements

class MockRedeemEntitlementsUseCase: RedeemEntitlementsUseCase {

    typealias ExecuteResult = Result<EntitlementsSet, Error>

    init(result: ExecuteResult? = nil) {
        let repository = MockEntitlementsRepository()
        super.init(repository: repository)
        if let result = result {
            executeResult = result
        }
    }

    var executeCallCount = 0
    var executeResult: ExecuteResult = .failure(AnyError("Please add base result to `MockRedeemEntitlementsUseCase.execute`"))

    override func execute(completion: @escaping ClientCompletion<EntitlementsSet>) {
        executeCallCount += 1
        completion(executeResult)
    }
}
