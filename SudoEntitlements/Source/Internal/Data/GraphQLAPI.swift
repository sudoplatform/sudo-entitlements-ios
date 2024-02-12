// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

struct GraphQL {

internal final class ConsumeBooleanEntitlementsMutation: GraphQLMutation {
  internal static let operationString =
    "mutation ConsumeBooleanEntitlements($entitlementNames: [String!]!) {\n  consumeBooleanEntitlements(entitlementNames: $entitlementNames)\n}"

  internal var entitlementNames: [String]

  internal init(entitlementNames: [String]) {
    self.entitlementNames = entitlementNames
  }

  internal var variables: GraphQLMap? {
    return ["entitlementNames": entitlementNames]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("consumeBooleanEntitlements", arguments: ["entitlementNames": GraphQLVariable("entitlementNames")], type: .nonNull(.scalar(Bool.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(consumeBooleanEntitlements: Bool) {
      self.init(snapshot: ["__typename": "Mutation", "consumeBooleanEntitlements": consumeBooleanEntitlements])
    }

    internal var consumeBooleanEntitlements: Bool {
      get {
        return snapshot["consumeBooleanEntitlements"]! as! Bool
      }
      set {
        snapshot.updateValue(newValue, forKey: "consumeBooleanEntitlements")
      }
    }
  }
}

internal final class GetEntitlementsQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEntitlements {\n  getEntitlements {\n    __typename\n    ...EntitlementsSet\n  }\n}"

  internal static var requestString: String { return operationString.appending(EntitlementsSet.fragmentString).appending(Entitlement.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEntitlements", type: .object(GetEntitlement.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEntitlements: GetEntitlement? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEntitlements": getEntitlements.flatMap { $0.snapshot }])
    }

    internal var getEntitlements: GetEntitlement? {
      get {
        return (snapshot["getEntitlements"] as? Snapshot).flatMap { GetEntitlement(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getEntitlements")
      }
    }

    internal struct GetEntitlement: GraphQLSelectionSet {
      internal static let possibleTypes = ["EntitlementsSet"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Double.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Double, name: String, description: String? = nil, entitlements: [Entitlement]) {
        self.init(snapshot: ["__typename": "EntitlementsSet", "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version, "name": name, "description": description, "entitlements": entitlements.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var version: Double {
        get {
          return snapshot["version"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      internal var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      internal var entitlements: [Entitlement] {
        get {
          return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var entitlementsSet: EntitlementsSet {
          get {
            return EntitlementsSet(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Entitlement: GraphQLSelectionSet {
        internal static let possibleTypes = ["Entitlement"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("value", type: .nonNull(.scalar(Double.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(name: String, description: String? = nil, value: Double) {
          self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        internal var description: String? {
          get {
            return snapshot["description"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "description")
          }
        }

        internal var value: Double {
          get {
            return snapshot["value"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "value")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var entitlement: Entitlement {
            get {
              return Entitlement(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class GetEntitlementsConsumptionQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEntitlementsConsumption {\n  getEntitlementsConsumption {\n    __typename\n    ...EntitlementsConsumption\n  }\n}"

  internal static var requestString: String { return operationString.appending(EntitlementsConsumption.fragmentString).appending(UserEntitlements.fragmentString).appending(Entitlement.fragmentString).appending(EntitlementConsumption.fragmentString).appending(EntitlementConsumer.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEntitlementsConsumption", type: .nonNull(.object(GetEntitlementsConsumption.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEntitlementsConsumption: GetEntitlementsConsumption) {
      self.init(snapshot: ["__typename": "Query", "getEntitlementsConsumption": getEntitlementsConsumption.snapshot])
    }

    internal var getEntitlementsConsumption: GetEntitlementsConsumption {
      get {
        return GetEntitlementsConsumption(snapshot: snapshot["getEntitlementsConsumption"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getEntitlementsConsumption")
      }
    }

    internal struct GetEntitlementsConsumption: GraphQLSelectionSet {
      internal static let possibleTypes = ["EntitlementsConsumption"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("entitlements", type: .nonNull(.object(Entitlement.selections))),
        GraphQLField("consumption", type: .nonNull(.list(.nonNull(.object(Consumption.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(entitlements: Entitlement, consumption: [Consumption]) {
        self.init(snapshot: ["__typename": "EntitlementsConsumption", "entitlements": entitlements.snapshot, "consumption": consumption.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var entitlements: Entitlement {
        get {
          return Entitlement(snapshot: snapshot["entitlements"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "entitlements")
        }
      }

      internal var consumption: [Consumption] {
        get {
          return (snapshot["consumption"] as! [Snapshot]).map { Consumption(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "consumption")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var entitlementsConsumption: EntitlementsConsumption {
          get {
            return EntitlementsConsumption(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Entitlement: GraphQLSelectionSet {
        internal static let possibleTypes = ["UserEntitlements"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("version", type: .nonNull(.scalar(Double.self))),
          GraphQLField("entitlementsSetName", type: .scalar(String.self)),
          GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(version: Double, entitlementsSetName: String? = nil, entitlements: [Entitlement]) {
          self.init(snapshot: ["__typename": "UserEntitlements", "version": version, "entitlementsSetName": entitlementsSetName, "entitlements": entitlements.map { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var version: Double {
          get {
            return snapshot["version"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var entitlementsSetName: String? {
          get {
            return snapshot["entitlementsSetName"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "entitlementsSetName")
          }
        }

        internal var entitlements: [Entitlement] {
          get {
            return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var userEntitlements: UserEntitlements {
            get {
              return UserEntitlements(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Entitlement: GraphQLSelectionSet {
          internal static let possibleTypes = ["Entitlement"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("value", type: .nonNull(.scalar(Double.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(name: String, description: String? = nil, value: Double) {
            self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var name: String {
            get {
              return snapshot["name"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }

          internal var description: String? {
            get {
              return snapshot["description"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "description")
            }
          }

          internal var value: Double {
            get {
              return snapshot["value"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "value")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var entitlement: Entitlement {
              get {
                return Entitlement(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }

      internal struct Consumption: GraphQLSelectionSet {
        internal static let possibleTypes = ["EntitlementConsumption"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("consumer", type: .object(Consumer.selections)),
          GraphQLField("value", type: .nonNull(.scalar(Double.self))),
          GraphQLField("consumed", type: .nonNull(.scalar(Double.self))),
          GraphQLField("available", type: .nonNull(.scalar(Double.self))),
          GraphQLField("firstConsumedAtEpochMs", type: .scalar(Double.self)),
          GraphQLField("lastConsumedAtEpochMs", type: .scalar(Double.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(name: String, consumer: Consumer? = nil, value: Double, consumed: Double, available: Double, firstConsumedAtEpochMs: Double? = nil, lastConsumedAtEpochMs: Double? = nil) {
          self.init(snapshot: ["__typename": "EntitlementConsumption", "name": name, "consumer": consumer.flatMap { $0.snapshot }, "value": value, "consumed": consumed, "available": available, "firstConsumedAtEpochMs": firstConsumedAtEpochMs, "lastConsumedAtEpochMs": lastConsumedAtEpochMs])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        internal var consumer: Consumer? {
          get {
            return (snapshot["consumer"] as? Snapshot).flatMap { Consumer(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "consumer")
          }
        }

        internal var value: Double {
          get {
            return snapshot["value"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "value")
          }
        }

        internal var consumed: Double {
          get {
            return snapshot["consumed"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "consumed")
          }
        }

        internal var available: Double {
          get {
            return snapshot["available"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "available")
          }
        }

        internal var firstConsumedAtEpochMs: Double? {
          get {
            return snapshot["firstConsumedAtEpochMs"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "firstConsumedAtEpochMs")
          }
        }

        internal var lastConsumedAtEpochMs: Double? {
          get {
            return snapshot["lastConsumedAtEpochMs"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "lastConsumedAtEpochMs")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var entitlementConsumption: EntitlementConsumption {
            get {
              return EntitlementConsumption(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Consumer: GraphQLSelectionSet {
          internal static let possibleTypes = ["EntitlementConsumer"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: GraphQLID, issuer: String) {
            self.init(snapshot: ["__typename": "EntitlementConsumer", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var entitlementConsumer: EntitlementConsumer {
              get {
                return EntitlementConsumer(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

internal final class GetExternalIdQuery: GraphQLQuery {
  internal static let operationString =
    "query GetExternalId {\n  getExternalId\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getExternalId", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getExternalId: String) {
      self.init(snapshot: ["__typename": "Query", "getExternalId": getExternalId])
    }

    internal var getExternalId: String {
      get {
        return snapshot["getExternalId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "getExternalId")
      }
    }
  }
}

internal final class RedeemEntitlementsMutation: GraphQLMutation {
  internal static let operationString =
    "mutation RedeemEntitlements {\n  redeemEntitlements {\n    __typename\n    ...EntitlementsSet\n  }\n}"

  internal static var requestString: String { return operationString.appending(EntitlementsSet.fragmentString).appending(Entitlement.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("redeemEntitlements", type: .nonNull(.object(RedeemEntitlement.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(redeemEntitlements: RedeemEntitlement) {
      self.init(snapshot: ["__typename": "Mutation", "redeemEntitlements": redeemEntitlements.snapshot])
    }

    internal var redeemEntitlements: RedeemEntitlement {
      get {
        return RedeemEntitlement(snapshot: snapshot["redeemEntitlements"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "redeemEntitlements")
      }
    }

    internal struct RedeemEntitlement: GraphQLSelectionSet {
      internal static let possibleTypes = ["EntitlementsSet"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Double.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Double, name: String, description: String? = nil, entitlements: [Entitlement]) {
        self.init(snapshot: ["__typename": "EntitlementsSet", "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version, "name": name, "description": description, "entitlements": entitlements.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var version: Double {
        get {
          return snapshot["version"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      internal var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      internal var entitlements: [Entitlement] {
        get {
          return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var entitlementsSet: EntitlementsSet {
          get {
            return EntitlementsSet(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Entitlement: GraphQLSelectionSet {
        internal static let possibleTypes = ["Entitlement"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("value", type: .nonNull(.scalar(Double.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(name: String, description: String? = nil, value: Double) {
          self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        internal var description: String? {
          get {
            return snapshot["description"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "description")
          }
        }

        internal var value: Double {
          get {
            return snapshot["value"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "value")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var entitlement: Entitlement {
            get {
              return Entitlement(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal struct Entitlement: GraphQLFragment {
  internal static let fragmentString =
    "fragment Entitlement on Entitlement {\n  __typename\n  name\n  description\n  value\n}"

  internal static let possibleTypes = ["Entitlement"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("value", type: .nonNull(.scalar(Double.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(name: String, description: String? = nil, value: Double) {
    self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  internal var description: String? {
    get {
      return snapshot["description"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "description")
    }
  }

  internal var value: Double {
    get {
      return snapshot["value"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "value")
    }
  }
}

internal struct EntitlementConsumer: GraphQLFragment {
  internal static let fragmentString =
    "fragment EntitlementConsumer on EntitlementConsumer {\n  __typename\n  id\n  issuer\n}"

  internal static let possibleTypes = ["EntitlementConsumer"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, issuer: String) {
    self.init(snapshot: ["__typename": "EntitlementConsumer", "id": id, "issuer": issuer])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var issuer: String {
    get {
      return snapshot["issuer"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "issuer")
    }
  }
}

internal struct EntitlementConsumption: GraphQLFragment {
  internal static let fragmentString =
    "fragment EntitlementConsumption on EntitlementConsumption {\n  __typename\n  name\n  consumer {\n    __typename\n    ...EntitlementConsumer\n  }\n  value\n  consumed\n  available\n  firstConsumedAtEpochMs\n  lastConsumedAtEpochMs\n}"

  internal static let possibleTypes = ["EntitlementConsumption"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("consumer", type: .object(Consumer.selections)),
    GraphQLField("value", type: .nonNull(.scalar(Double.self))),
    GraphQLField("consumed", type: .nonNull(.scalar(Double.self))),
    GraphQLField("available", type: .nonNull(.scalar(Double.self))),
    GraphQLField("firstConsumedAtEpochMs", type: .scalar(Double.self)),
    GraphQLField("lastConsumedAtEpochMs", type: .scalar(Double.self)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(name: String, consumer: Consumer? = nil, value: Double, consumed: Double, available: Double, firstConsumedAtEpochMs: Double? = nil, lastConsumedAtEpochMs: Double? = nil) {
    self.init(snapshot: ["__typename": "EntitlementConsumption", "name": name, "consumer": consumer.flatMap { $0.snapshot }, "value": value, "consumed": consumed, "available": available, "firstConsumedAtEpochMs": firstConsumedAtEpochMs, "lastConsumedAtEpochMs": lastConsumedAtEpochMs])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  internal var consumer: Consumer? {
    get {
      return (snapshot["consumer"] as? Snapshot).flatMap { Consumer(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "consumer")
    }
  }

  internal var value: Double {
    get {
      return snapshot["value"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "value")
    }
  }

  internal var consumed: Double {
    get {
      return snapshot["consumed"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "consumed")
    }
  }

  internal var available: Double {
    get {
      return snapshot["available"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "available")
    }
  }

  internal var firstConsumedAtEpochMs: Double? {
    get {
      return snapshot["firstConsumedAtEpochMs"] as? Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "firstConsumedAtEpochMs")
    }
  }

  internal var lastConsumedAtEpochMs: Double? {
    get {
      return snapshot["lastConsumedAtEpochMs"] as? Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "lastConsumedAtEpochMs")
    }
  }

  internal struct Consumer: GraphQLSelectionSet {
    internal static let possibleTypes = ["EntitlementConsumer"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: GraphQLID, issuer: String) {
      self.init(snapshot: ["__typename": "EntitlementConsumer", "id": id, "issuer": issuer])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: GraphQLID {
      get {
        return snapshot["id"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var issuer: String {
      get {
        return snapshot["issuer"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "issuer")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var entitlementConsumer: EntitlementConsumer {
        get {
          return EntitlementConsumer(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}

internal struct EntitlementsConsumption: GraphQLFragment {
  internal static let fragmentString =
    "fragment EntitlementsConsumption on EntitlementsConsumption {\n  __typename\n  entitlements {\n    __typename\n    ...UserEntitlements\n  }\n  consumption {\n    __typename\n    ...EntitlementConsumption\n  }\n}"

  internal static let possibleTypes = ["EntitlementsConsumption"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("entitlements", type: .nonNull(.object(Entitlement.selections))),
    GraphQLField("consumption", type: .nonNull(.list(.nonNull(.object(Consumption.selections))))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(entitlements: Entitlement, consumption: [Consumption]) {
    self.init(snapshot: ["__typename": "EntitlementsConsumption", "entitlements": entitlements.snapshot, "consumption": consumption.map { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var entitlements: Entitlement {
    get {
      return Entitlement(snapshot: snapshot["entitlements"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "entitlements")
    }
  }

  internal var consumption: [Consumption] {
    get {
      return (snapshot["consumption"] as! [Snapshot]).map { Consumption(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "consumption")
    }
  }

  internal struct Entitlement: GraphQLSelectionSet {
    internal static let possibleTypes = ["UserEntitlements"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("version", type: .nonNull(.scalar(Double.self))),
      GraphQLField("entitlementsSetName", type: .scalar(String.self)),
      GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(version: Double, entitlementsSetName: String? = nil, entitlements: [Entitlement]) {
      self.init(snapshot: ["__typename": "UserEntitlements", "version": version, "entitlementsSetName": entitlementsSetName, "entitlements": entitlements.map { $0.snapshot }])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var version: Double {
      get {
        return snapshot["version"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "version")
      }
    }

    internal var entitlementsSetName: String? {
      get {
        return snapshot["entitlementsSetName"] as? String
      }
      set {
        snapshot.updateValue(newValue, forKey: "entitlementsSetName")
      }
    }

    internal var entitlements: [Entitlement] {
      get {
        return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var userEntitlements: UserEntitlements {
        get {
          return UserEntitlements(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }

    internal struct Entitlement: GraphQLSelectionSet {
      internal static let possibleTypes = ["Entitlement"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("value", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(name: String, description: String? = nil, value: Double) {
        self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      internal var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      internal var value: Double {
        get {
          return snapshot["value"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "value")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var entitlement: Entitlement {
          get {
            return Entitlement(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }

  internal struct Consumption: GraphQLSelectionSet {
    internal static let possibleTypes = ["EntitlementConsumption"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("consumer", type: .object(Consumer.selections)),
      GraphQLField("value", type: .nonNull(.scalar(Double.self))),
      GraphQLField("consumed", type: .nonNull(.scalar(Double.self))),
      GraphQLField("available", type: .nonNull(.scalar(Double.self))),
      GraphQLField("firstConsumedAtEpochMs", type: .scalar(Double.self)),
      GraphQLField("lastConsumedAtEpochMs", type: .scalar(Double.self)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(name: String, consumer: Consumer? = nil, value: Double, consumed: Double, available: Double, firstConsumedAtEpochMs: Double? = nil, lastConsumedAtEpochMs: Double? = nil) {
      self.init(snapshot: ["__typename": "EntitlementConsumption", "name": name, "consumer": consumer.flatMap { $0.snapshot }, "value": value, "consumed": consumed, "available": available, "firstConsumedAtEpochMs": firstConsumedAtEpochMs, "lastConsumedAtEpochMs": lastConsumedAtEpochMs])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var name: String {
      get {
        return snapshot["name"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "name")
      }
    }

    internal var consumer: Consumer? {
      get {
        return (snapshot["consumer"] as? Snapshot).flatMap { Consumer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "consumer")
      }
    }

    internal var value: Double {
      get {
        return snapshot["value"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "value")
      }
    }

    internal var consumed: Double {
      get {
        return snapshot["consumed"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "consumed")
      }
    }

    internal var available: Double {
      get {
        return snapshot["available"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "available")
      }
    }

    internal var firstConsumedAtEpochMs: Double? {
      get {
        return snapshot["firstConsumedAtEpochMs"] as? Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "firstConsumedAtEpochMs")
      }
    }

    internal var lastConsumedAtEpochMs: Double? {
      get {
        return snapshot["lastConsumedAtEpochMs"] as? Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "lastConsumedAtEpochMs")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var entitlementConsumption: EntitlementConsumption {
        get {
          return EntitlementConsumption(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }

    internal struct Consumer: GraphQLSelectionSet {
      internal static let possibleTypes = ["EntitlementConsumer"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, issuer: String) {
        self.init(snapshot: ["__typename": "EntitlementConsumer", "id": id, "issuer": issuer])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var issuer: String {
        get {
          return snapshot["issuer"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "issuer")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var entitlementConsumer: EntitlementConsumer {
          get {
            return EntitlementConsumer(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal struct EntitlementsSet: GraphQLFragment {
  internal static let fragmentString =
    "fragment EntitlementsSet on EntitlementsSet {\n  __typename\n  createdAtEpochMs\n  updatedAtEpochMs\n  version\n  name\n  description\n  entitlements {\n    __typename\n    ...Entitlement\n  }\n}"

  internal static let possibleTypes = ["EntitlementsSet"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("version", type: .nonNull(.scalar(Double.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Double, name: String, description: String? = nil, entitlements: [Entitlement]) {
    self.init(snapshot: ["__typename": "EntitlementsSet", "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version, "name": name, "description": description, "entitlements": entitlements.map { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }

  internal var version: Double {
    get {
      return snapshot["version"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  internal var description: String? {
    get {
      return snapshot["description"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "description")
    }
  }

  internal var entitlements: [Entitlement] {
    get {
      return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
    }
  }

  internal struct Entitlement: GraphQLSelectionSet {
    internal static let possibleTypes = ["Entitlement"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("description", type: .scalar(String.self)),
      GraphQLField("value", type: .nonNull(.scalar(Double.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(name: String, description: String? = nil, value: Double) {
      self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var name: String {
      get {
        return snapshot["name"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "name")
      }
    }

    internal var description: String? {
      get {
        return snapshot["description"] as? String
      }
      set {
        snapshot.updateValue(newValue, forKey: "description")
      }
    }

    internal var value: Double {
      get {
        return snapshot["value"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "value")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var entitlement: Entitlement {
        get {
          return Entitlement(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}

internal struct UserEntitlements: GraphQLFragment {
  internal static let fragmentString =
    "fragment UserEntitlements on UserEntitlements {\n  __typename\n  version\n  entitlementsSetName\n  entitlements {\n    __typename\n    ...Entitlement\n  }\n}"

  internal static let possibleTypes = ["UserEntitlements"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("version", type: .nonNull(.scalar(Double.self))),
    GraphQLField("entitlementsSetName", type: .scalar(String.self)),
    GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(version: Double, entitlementsSetName: String? = nil, entitlements: [Entitlement]) {
    self.init(snapshot: ["__typename": "UserEntitlements", "version": version, "entitlementsSetName": entitlementsSetName, "entitlements": entitlements.map { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var version: Double {
    get {
      return snapshot["version"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var entitlementsSetName: String? {
    get {
      return snapshot["entitlementsSetName"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "entitlementsSetName")
    }
  }

  internal var entitlements: [Entitlement] {
    get {
      return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
    }
  }

  internal struct Entitlement: GraphQLSelectionSet {
    internal static let possibleTypes = ["Entitlement"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("description", type: .scalar(String.self)),
      GraphQLField("value", type: .nonNull(.scalar(Double.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(name: String, description: String? = nil, value: Double) {
      self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var name: String {
      get {
        return snapshot["name"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "name")
      }
    }

    internal var description: String? {
      get {
        return snapshot["description"] as? String
      }
      set {
        snapshot.updateValue(newValue, forKey: "description")
      }
    }

    internal var value: Double {
      get {
        return snapshot["value"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "value")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var entitlement: Entitlement {
        get {
          return Entitlement(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}
}
