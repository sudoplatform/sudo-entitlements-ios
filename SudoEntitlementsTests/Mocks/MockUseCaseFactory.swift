//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

@testable import SudoEntitlements

class MockUseCaseFactory: UseCaseFactory {

    var generateGetEntitlementsUseCaseCount = 0
    var generateGetEntitlementsUseCaseResult: MockGetEntitlementsUseCase?
    
    override func generateGetEntitlementsUseCase() -> GetEntitlementsUseCase {
        generateGetEntitlementsUseCaseCount += 1
        guard let useCase = generateGetEntitlementsUseCaseResult else {
            return super.generateGetEntitlementsUseCase()
        }
        return useCase
    }

    var generateRedeemEntitlementsUseCaseCount = 0
    var generateRedeemEntitlementsUseCaseResult: MockRedeemEntitlementsUseCase?

    override func generateRedeemEntitlementsUseCase() -> RedeemEntitlementsUseCase {
        generateRedeemEntitlementsUseCaseCount += 1
        guard let useCase = generateRedeemEntitlementsUseCaseResult else {
            return super.generateRedeemEntitlementsUseCase()
        }
        return useCase
    }
}
