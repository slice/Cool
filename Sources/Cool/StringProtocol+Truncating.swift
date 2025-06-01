public extension StringProtocol {
  func truncating(toOverallMaxLength limit: Int, with ending: String = "…") -> String {
    precondition(limit > 1, "tried to truncate string with bogus max length \(limit)")
    guard count > limit else { return String(self) }
    return prefix(limit - 1) + ending
  }
}
