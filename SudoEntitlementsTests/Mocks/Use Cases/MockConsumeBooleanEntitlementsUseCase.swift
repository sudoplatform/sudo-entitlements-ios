//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

@testable import SudoEntitlements

class MockConsumeBooleanEntitlementsUseCase: ConsumeBooleanEntitlementsUseCase {

    typealias ExecuteResult = Result<Void, Error>

    init(result: ExecuteResult? = nil) {
        let repository = MockEntitlementsRepository()
        super.init(repository: repository)
        if let result = result {
            executeResult = result
        }
    }

    var executeCallCount = 0
    var executeResult: ExecuteResult = .failure(AnyError("Please add base result to `MockConsumeBooleanEntitlementsUseCase.execute`"))

    override func execute(entitlementNames: [String]) async throws {
        executeCallCount += 1
        switch (executeResult) {
        case .failure(let error):
            throw error
        case .success:
            return
        }
    }
}
