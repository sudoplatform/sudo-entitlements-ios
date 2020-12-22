//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import SudoApiClient
import SudoLogging
import SudoOperations
import SudoUser

/// Default Client API Endpoint for interacting with the Entitlements Service.
public class DefaultSudoEntitlementsClient: SudoEntitlementsClient {

    /// App sync client for peforming operations against the entitlements service.
    let appSyncClient: AWSAppSyncClient

    /// Used to log diagnostic and error information.
    let logger: Logger

    /// Utility factory class to generate use cases.
    let useCaseFactory: UseCaseFactory
    
    /// Repository that does the work of interacting with the service via GraphQL
    let repository: EntitlementsRepository
    
    // User client used to sign-in prior to accessing service
    let userClient: SudoUserClient

    var allResetables: [Resetable] {
        return [
            repository
        ]
    }
    
    /// Initialize an instance of `DefaultSudoEntitlementsClient`. It uses configuration parameters defined in `sudoplatformconfig.json` file located in the app
    /// bundle.
    /// - Parameters:
    ///   - userClient: SudoUserClient instance used for authentication.
    /// Throws:
    ///     - `SudoEntitlementsError` if invalid config.
    public convenience init(userClient: SudoUserClient) throws {
        guard let appSyncClient = try ApiClientManager.instance?.getClient(sudoUserClient: userClient) else {
            throw SudoEntitlementsError.invalidConfig
        }
        let repository = DefaultEntitlementsRepository(appSyncClient: appSyncClient)
        self.init(
            appSyncClient: appSyncClient,
            userClient: userClient,
            useCaseFactory: UseCaseFactory(repository: repository),
            repository: repository
        )
    }

    /// Initialize an instance of `DefaultSudoEntitlementsClient`.
    ///
    /// This is used internally for injection and mock testing.
    init(
        appSyncClient: AWSAppSyncClient,
        userClient: SudoUserClient,
        useCaseFactory: UseCaseFactory,
        repository: EntitlementsRepository,
        logger: Logger = .entitlementsSDKLogger
    ) {
        self.appSyncClient = appSyncClient
        self.logger = logger
        self.useCaseFactory = useCaseFactory
        self.repository = repository
        self.userClient = userClient
    }

    public func reset() throws {
        allResetables.forEach { $0.reset() }
        try self.appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: false))
    }

    public func redeemEntitlements(completion: @escaping ClientCompletion<EntitlementsSet>) {
        do {
            if try !userClient.isSignedIn() {
                completion(.failure(SudoEntitlementsError.notSignedIn))
                return
            }
        }
        catch {
            completion(.failure(error))
            return
        }
  
        let useCaseCompletion: ClientCompletion<EntitlementsSet> = { result in
            completion(result)
        }
        let useCase = useCaseFactory.generateRedeemEntitlementsUseCase()
        useCase.execute(completion: useCaseCompletion)
    }

    public func getEntitlementsConsumption(completion: @escaping ClientCompletion<EntitlementsConsumption>) {
        do {
            if try !userClient.isSignedIn() {
                completion(.failure(SudoEntitlementsError.notSignedIn))
                return
            }
        }
        catch {
            completion(.failure(error))
            return
        }
  
        let useCaseCompletion: ClientCompletion<EntitlementsConsumption> = { result in
            completion(result)
        }
        let useCase = useCaseFactory.generateGetEntitlementsConsumptionUseCase()
        useCase.execute(completion: useCaseCompletion)
    }

    public func getEntitlements(completion: @escaping ClientCompletion<EntitlementsSet?>) {
        do {
            if try !userClient.isSignedIn() {
                completion(.failure(SudoEntitlementsError.notSignedIn))
                return
            }
        }
        catch {
            completion(.failure(error))
            return
        }
  
        let useCaseCompletion: ClientCompletion<EntitlementsSet?> = { result in
            completion(result)
        }
        let useCase = useCaseFactory.generateGetEntitlementsUseCase()
        useCase.execute(completion: useCaseCompletion)
    }
}
