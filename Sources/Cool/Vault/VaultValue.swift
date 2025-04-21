import Foundation

public protocol VaultValue {
  associatedtype VaultRepresentation = Self
  init?(userDefaultsRepresentation: VaultRepresentation)
  var userDefaultsRepresentation: VaultRepresentation { get }
}

public extension VaultValue where VaultRepresentation == Self {
  init?(userDefaultsRepresentation: VaultRepresentation) {
    self = userDefaultsRepresentation
  }

  var userDefaultsRepresentation: VaultRepresentation { self }
}

extension Int: VaultValue {}

extension Double: VaultValue {
  public typealias VaultRepresentation = String

  public init?(userDefaultsRepresentation: String) {
    guard let double = Double(userDefaultsRepresentation) else { return nil }
    self = double
  }

  public var userDefaultsRepresentation: String { String(self) }
}

extension Bool: VaultValue {}

extension String: VaultValue {}

extension URL: VaultValue {}

extension Data: VaultValue {}
