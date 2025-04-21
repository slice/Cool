import Foundation

public struct VaultKey<Value: VaultValue> {
  public let name: String
  public let defaultValue: Value

  public init(_ name: String, default value: Value) {
    self.name = name
    defaultValue = value
  }

  public var value: Value {
    get {
      guard let representation = UserDefaults.standard.object(forKey: name) as? Value.VaultRepresentation,
            let value = Value(userDefaultsRepresentation: representation)
      else {
        return defaultValue
      }
      return value
    }
    nonmutating set { UserDefaults.standard.set(newValue.userDefaultsRepresentation, forKey: name) }
  }

  public func reset() {
    UserDefaults.standard.removeObject(forKey: name)
  }
}

// `UserDefaults` provides synchronization (?)
extension VaultKey: @unchecked Sendable {}
