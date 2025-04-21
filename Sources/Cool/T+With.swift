@discardableResult
@_transparent
public func with<T>(_ value: consuming T, transform: (inout T) throws -> Void) rethrows -> T {
  try transform(&value)
  return consume value
}
