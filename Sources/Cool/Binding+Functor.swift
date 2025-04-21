import SwiftUI

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
public extension Binding {
  @inlinable
  func viewing<T>(/* @_inheritActorContext */ _ transform: @escaping /* @isolated(any) */ @Sendable (Value) -> T) -> Binding<T> {
    Binding<T>(get: { transform(self.wrappedValue) }, set: { _ in })
  }

  @inlinable
  func isNonNil<T>() -> Binding<Bool> where Value == T? {
    viewing { $0 != nil }
  }
}
