import Foundation

public extension URL {
  @inlinable
  static func / (base: URL, component: String) -> URL {
    if #available(*, macOS 13, iOS 16, tvOS 16, watchOS 9) {
      base.appending(path: component)
    } else {
      base.appendingPathComponent(component)
    }
  }
}
