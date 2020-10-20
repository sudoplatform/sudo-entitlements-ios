//  This file was automatically generated and should not be edited.

import AWSAppSync

public final class GetEntitlementsQuery: GraphQLQuery {
  public static let operationString =
    "query GetEntitlements {\n  getEntitlements {\n    __typename\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n    name\n    description\n    entitlements {\n      __typename\n      name\n      description\n      value\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getEntitlements", type: .object(GetEntitlement.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getEntitlements: GetEntitlement? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEntitlements": getEntitlements.flatMap { $0.snapshot }])
    }

    public var getEntitlements: GetEntitlement? {
      get {
        return (snapshot["getEntitlements"] as? Snapshot).flatMap { GetEntitlement(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getEntitlements")
      }
    }

    public struct GetEntitlement: GraphQLSelectionSet {
      public static let possibleTypes = ["EntitlementsSet"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int, name: String, description: String? = nil, entitlements: [Entitlement]) {
        self.init(snapshot: ["__typename": "EntitlementsSet", "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version, "name": name, "description": description, "entitlements": entitlements.map { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      public var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      public var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var entitlements: [Entitlement] {
        get {
          return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
        }
      }

      public struct Entitlement: GraphQLSelectionSet {
        public static let possibleTypes = ["Entitlement"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("value", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String, description: String? = nil, value: Int) {
          self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        public var description: String? {
          get {
            return snapshot["description"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "description")
          }
        }

        public var value: Int {
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

public final class RedeemEntitlementsMutation: GraphQLMutation {
  public static let operationString =
    "mutation RedeemEntitlements {\n  redeemEntitlements {\n    __typename\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n    name\n    description\n    entitlements {\n      __typename\n      name\n      description\n      value\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("redeemEntitlements", type: .nonNull(.object(RedeemEntitlement.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(redeemEntitlements: RedeemEntitlement) {
      self.init(snapshot: ["__typename": "Mutation", "redeemEntitlements": redeemEntitlements.snapshot])
    }

    public var redeemEntitlements: RedeemEntitlement {
      get {
        return RedeemEntitlement(snapshot: snapshot["redeemEntitlements"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "redeemEntitlements")
      }
    }

    public struct RedeemEntitlement: GraphQLSelectionSet {
      public static let possibleTypes = ["EntitlementsSet"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("entitlements", type: .nonNull(.list(.nonNull(.object(Entitlement.selections))))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int, name: String, description: String? = nil, entitlements: [Entitlement]) {
        self.init(snapshot: ["__typename": "EntitlementsSet", "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version, "name": name, "description": description, "entitlements": entitlements.map { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      public var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      public var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var entitlements: [Entitlement] {
        get {
          return (snapshot["entitlements"] as! [Snapshot]).map { Entitlement(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "entitlements")
        }
      }

      public struct Entitlement: GraphQLSelectionSet {
        public static let possibleTypes = ["Entitlement"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("value", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String, description: String? = nil, value: Int) {
          self.init(snapshot: ["__typename": "Entitlement", "name": name, "description": description, "value": value])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        public var description: String? {
          get {
            return snapshot["description"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "description")
          }
        }

        public var value: Int {
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
