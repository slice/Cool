@dynamicMemberLookup
public enum Vault {
  // doesn't have good autocomplete
  public static subscript<Value>(dynamicMember keyPath: KeyPath<VaultKeys, VaultKey<Value>>) -> Value {
    get { VaultKeys()[keyPath: keyPath].value }
    set { VaultKeys()[keyPath: keyPath].value = newValue }
  }

  public static subscript<Value>(_ keyPath: KeyPath<VaultKeys, VaultKey<Value>>) -> Value {
    get { VaultKeys()[keyPath: keyPath].value }
    set { VaultKeys()[keyPath: keyPath].value = newValue }
  }

  public static func reset(_ keyPath: KeyPath<VaultKeys, VaultKey<some Any>>) {
    VaultKeys()[keyPath: keyPath].reset()
  }
}
