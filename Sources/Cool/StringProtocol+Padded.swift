public enum StringPaddingTarget {
  /** Adds the fill text to the beginning of the string. The text becomes "right-aligned". */
  case start
  /** Adds the fill text to the end of the string. The text becomes "left-aligned". */
  case end
}

public extension StringProtocol {
  // not naming this `padding` because it conflicts with the `NSString` method
  @inlinable
  func padded(toMinLength len: Int, with fill: String = " ", addingFillTo alignment: StringPaddingTarget = .end) -> String {
    guard count < len else { return String(self) }

    let correction = String(repeating: fill, count: len - count)
    return switch alignment {
    case .end: self + correction
    case .start: correction + self
    }
  }
}
