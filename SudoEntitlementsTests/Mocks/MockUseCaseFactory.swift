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

    var generateGetEntitlementsConsumptionUseCaseCount = 0
    var generateGetEntitlementsConsumptionUseCaseResult: MockGetEntitlementsConsumptionUseCase?
    
    override func generateGetEntitlementsConsumptionUseCase() -> GetEntitlementsConsumptionUseCase {
        generateGetEntitlementsConsumptionUseCaseCount += 1
        guard let useCase = generateGetEntitlementsConsumptionUseCaseResult else {
            return super.generateGetEntitlementsConsumptionUseCase()
        }
        return useCase
    }

    var generateGetExternalIdUseCaseCount = 0
    var generateGetExternalIdUseCaseResult: MockGetExternalIdUseCase?
    
    override func generateGetExternalIdUseCase() -> GetExternalIdUseCase {
        generateGetExternalIdUseCaseCount += 1
        guard let useCase = generateGetExternalIdUseCaseResult else {
            return super.generateGetExternalIdUseCase()
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

    var generateConsumeBooleanEntitlementsUseCaseCount = 0
    var generateConsumeBooleanEntitlementsUseCaseResult: MockConsumeBooleanEntitlementsUseCase?

    override func generateConsumeBooleanEntitlementsUseCase() -> ConsumeBooleanEntitlementsUseCase {
        generateConsumeBooleanEntitlementsUseCaseCount += 1
        guard let useCase = generateConsumeBooleanEntitlementsUseCaseResult else {
            return super.generateConsumeBooleanEntitlementsUseCase()
        }
        return useCase
    }
}
