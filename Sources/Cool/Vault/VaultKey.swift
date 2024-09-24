import Foundation

public struct VaultKey<Value: VaultValue> {
  public let name: String
  public let defaultValue: Value

  init(_ name: String, default value: Value) {
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
    nonmutating set { UserDefaults.standard.setValue(newValue, forKey: name) }
  }

  public func reset() {
    UserDefaults.standard.removeObject(forKey: name)
  }
}

extension VaultKey {
  public init<Wrapped>(_ name: String) where Value == Wrapped? {
    self.name = name
    defaultValue = nil
  }
}

// `UserDefaults` provides synchronization (?)
extension VaultKey: @unchecked Sendable {}
