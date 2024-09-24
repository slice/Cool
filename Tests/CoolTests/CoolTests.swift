@testable import Cool
import Testing

extension VaultKeys {
  var cool: VaultKey<String> { .init("test", default: "foo") }
}

@Test func vaultBasic() async throws {
  #expect(Vault.cool == "foo")

  Vault.cool = "custom"
  #expect(Vault.cool == "custom")
  VaultKeys().cool.reset()
  #expect(Vault.cool == "foo")

  Vault.cool = "custom 2"
  #expect(Vault.cool == "custom 2")
  Vault.reset(\.cool)
  #expect(Vault.cool == "foo")

  Vault[\.cool] = "hello"
}
