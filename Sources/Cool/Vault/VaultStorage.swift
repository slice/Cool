import SwiftUI

// https://saagarjha.com/blog/2024/02/27/making-friends-with-attributegraph/

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct VaultStorage<Value: VaultValue> {
  let key: VaultKey<Value>

  @State
  var _update = false

  private final class Observer: NSObject {
    let key: String
    var _update: State<Bool>!

    init(key: VaultKey<Value>) {
      self.key = key.name
      super.init()
      UserDefaults.standard.addObserver(self, forKeyPath: self.key, context: nil)
    }

    deinit {
      UserDefaults.standard.removeObserver(self, forKeyPath: key)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
      _update.wrappedValue.toggle()
    }
  }

  private let observer: Observer

  init(_ key: KeyPath<VaultKeys, VaultKey<Value>>) {
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
  
  // FIXME: not concurrency safe
  //  var projectedValue: Binding<Value> {
  //    Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
  //  }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension VaultStorage: DynamicProperty {
  public func update() {
    observer._update = __update
  }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension VaultStorage {
  var hasExplicitValue: Bool {
    UserDefaults.standard.value(forKey: key.name) != nil
  }

  func reset() {
    UserDefaults.standard.removeObject(forKey: key.name)
  }
}
