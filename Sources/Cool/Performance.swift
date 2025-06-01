import Darwin

@inlinable
func format(nanoseconds nanos: UInt64) -> String {
  let us = 1000, ms = us * 1000, s = ms * 1000

  guard nanos >= us else { return "\(nanos)ns" }
  guard nanos >= ms else { return "\(nanos / numericCast(us))µs" }
  guard nanos >= s else { return "\(nanos / numericCast(ms))ms" }

  return "\((Double(nanos) / Double(s)).rounded())s"
}

extension StringProtocol {
  @usableFromInline
  func displayingForMeasurement() -> some StringProtocol {
    truncating(toOverallMaxLength: 32).padded(toMinLength: 32)
  }
}

@available(macOS 10.15, iOS 13, *)
@inlinable
@inline(__always)
public func measure<T>(_ label: String, @_inheritActorContext _ action: sending () async throws -> T) async rethrows -> sending T {
  let start = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  let result = try await action()
  let end = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  print("⏰ \(label.displayingForMeasurement()): \(format(nanoseconds: end - start))")
  return result
}

@available(macOS 10.15, iOS 13, *)
@inlinable
@inline(__always)
public func measure<T>(_ label: String, _ action: () throws -> T) rethrows -> T {
  let start = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  let result = try action()
  let end = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  print("⏰ \(label.displayingForMeasurement()): \(format(nanoseconds: end - start))")
  return result
}
