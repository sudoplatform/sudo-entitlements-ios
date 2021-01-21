// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

internal final class GetEntitlementsQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEntitlements {\n  getEntitlements {\n    __typename\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n    name\n    description\n    entitlements {\n      __typename\n      name\n      description\n      value\n    }\n  }\n}"

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
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("value", type: .nonNull(.scalar(Int.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(name: String, description: String? = nil, value: Int) {
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

        internal var value: Int {
          get {
            return snapshot["value"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "value")
          }
        }
      }
    }
  }
}

internal final class GetEntitlementsConsumptionQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEntitlementsConsumption {\n  getEntitlementsConsumption {\n    __typename\n    entitlements {\n      __typename\n      version\n      entitlementsSetName\n      entitlements {\n        __typename\n        name\n        description\n        value\n      }\n    }\n    consumption {\n      __typename\n      consumer {\n        __typename\n        id\n        issuer\n      }\n      name\n      value\n      consumed\n      available\n      firstConsumedAtEpochMs\n      lastConsumedAtEpochMs\n    }\n  }\n}"

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
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("value", type: .nonNull(.scalar(Int.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(name: String, description: String? = nil, value: Int) {
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

          internal var value: Int {
            get {
              return snapshot["value"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "value")
            }
          }
        }
      }

      internal struct Consumption: GraphQLSelectionSet {
        internal static let possibleTypes = ["EntitlementConsumption"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("consumer", type: .object(Consumer.selections)),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("value", type: .nonNull(.scalar(Int.self))),
          GraphQLField("consumed", type: .nonNull(.scalar(Int.self))),
          GraphQLField("available", type: .nonNull(.scalar(Int.self))),
          GraphQLField("firstConsumedAtEpochMs", type: .scalar(Double.self)),
          GraphQLField("lastConsumedAtEpochMs", type: .scalar(Double.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(consumer: Consumer? = nil, name: String, value: Int, consumed: Int, available: Int, firstConsumedAtEpochMs: Double? = nil, lastConsumedAtEpochMs: Double? = nil) {
          self.init(snapshot: ["__typename": "EntitlementConsumption", "consumer": consumer.flatMap { $0.snapshot }, "name": name, "value": value, "consumed": consumed, "available": available, "firstConsumedAtEpochMs": firstConsumedAtEpochMs, "lastConsumedAtEpochMs": lastConsumedAtEpochMs])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
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

        internal var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        internal var value: Int {
          get {
            return snapshot["value"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "value")
          }
        }

        internal var consumed: Int {
          get {
            return snapshot["consumed"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "consumed")
          }
        }

        internal var available: Int {
          get {
            return snapshot["available"]! as! Int
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
      }
    }
  }
}

internal final class RedeemEntitlementsMutation: GraphQLMutation {
  internal static let operationString =
    "mutation RedeemEntitlements {\n  redeemEntitlements {\n    __typename\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n    name\n    description\n    entitlements {\n      __typename\n      name\n      description\n      value\n    }\n  }\n}"

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
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("value", type: .nonNull(.scalar(Int.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(name: String, description: String? = nil, value: Int) {
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

        internal var value: Int {
          get {
            return snapshot["value"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "value")
          }
        }
      }
    }
  }
}