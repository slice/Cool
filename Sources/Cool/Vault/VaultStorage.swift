import os
import SwiftUI

// https://saagarjha.com/blog/2024/02/27/making-friends-with-attributegraph/

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
@propertyWrapper
public struct VaultStorage<Value: VaultValue> {
  let key: VaultKey<Value>

  @State
  var _update = false

  private final class Observer: NSObject, Sendable {
    let key: String
    let _update = OSAllocatedUnfairLock<State<Bool>?>(initialState: nil)

    init(key: VaultKey<Value>) {
      self.key = key.name
      super.init()
      UserDefaults.standard.addObserver(self, forKeyPath: self.key, context: nil)
    }

    deinit {
      UserDefaults.standard.removeObserver(self, forKeyPath: key)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
      _update.withLock { $0?.wrappedValue.toggle() }
    }
  }

  private let observer: Observer

  public init(_ key: KeyPath<VaultKeys, VaultKey<Value>>) {
    self.key = VaultKeys()[keyPath: key]
    observer = Observer(key: self.key)
  }

  public var wrappedValue: Value {
    get {
      _ = _update
      return key.value
    }

    nonmutating set {
      _update.toggle()
      key.value = newValue
    }
  }

  public var projectedValue: Binding<Value> {
    Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
  }
}

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
extension VaultStorage: Sendable where Value: Sendable {
  public var projectedValue: Binding<Value> {
    Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
  }
}

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
extension VaultStorage: DynamicProperty {
  public func update() {
    observer._update.withLockUnchecked { $0 = __update }
  }
}

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
extension VaultStorage {
  var hasExplicitValue: Bool {
    UserDefaults.standard.value(forKey: key.name) != nil
  }

  func reset() {
    UserDefaults.standard.removeObject(forKey: key.name)
  }
}
