@discardableResult
@inlinable
@inline(__always)
public func with<T>(_ value: consuming T, transform: (inout T) throws -> Void) rethrows -> T {
  try transform(&value)
  return consume value
}
