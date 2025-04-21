import Darwin

@available(macOS 10.15, iOS 13, *)
@inlinable
@inline(__always)
public func measure<T>(_ label: String, @_inheritActorContext _ action: sending () async throws -> T) async rethrows -> sending T {
  let start = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  let result = try await action()
  let end = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  print("[measure] \(label) took \((end - start) / 1000)µs")
  return result
}

@available(macOS 10.15, iOS 13, *)
@inlinable
@inline(__always)
public func measure<T>(_ label: String, _ action: () throws -> T) rethrows -> T {
  let start = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  let result = try action()
  let end = clock_gettime_nsec_np(CLOCK_MONOTONIC)
  print("[measure] \(label) took \((end - start) / 1000)µs")
  return result
}
