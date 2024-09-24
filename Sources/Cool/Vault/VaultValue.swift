import Foundation

public protocol VaultValue {
  associatedtype VaultRepresentation = Self
  init?(userDefaultsRepresentation: VaultRepresentation)
}

extension VaultValue where VaultRepresentation == Self {
  public init?(userDefaultsRepresentation: VaultRepresentation) {
    self = userDefaultsRepresentation
  }
}

extension Int: VaultValue {}

extension Double: VaultValue {}

extension Bool: VaultValue {}

extension String: VaultValue {}

extension URL: VaultValue {}

extension Data: VaultValue {}

extension Optional: VaultValue where Wrapped: VaultValue {
  public typealias VaultRepresentation = Wrapped.VaultRepresentation

  public init?(userDefaultsRepresentation: Wrapped.VaultRepresentation) {
    self = Wrapped(userDefaultsRepresentation: userDefaultsRepresentation)
  }
}
