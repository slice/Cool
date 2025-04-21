import SwiftUI

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
public extension EdgeInsets {
  @inlinable
  init(vertical: CGFloat = 0.0, horizontal: CGFloat = 0.0) {
    self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
  }
}
