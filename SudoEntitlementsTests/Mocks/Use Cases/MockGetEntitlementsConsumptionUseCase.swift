//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

@testable import SudoEntitlements

class MockGetEntitlementsConsumptionUseCase: GetEntitlementsConsumptionUseCase {

    typealias ExecuteResult = Result<EntitlementsConsumption, Error>

    init(result: ExecuteResult? = nil) {
        let repository = MockEntitlementsRepository()
        super.init(repository: repository)
        if let result = result {
            executeResult = result
        }
    }

    var executeCallCount = 0
    var executeResult: ExecuteResult = .failure(AnyError("Please add base result to `MockGetEntitlementsConsumptionUseCase.execute`"))

    override func execute() async throws -> EntitlementsConsumption {
        executeCallCount += 1
        switch (executeResult) {
        case .failure(let error):
            throw error
        
        case .success(let result):
            return result
        }
    }
}
