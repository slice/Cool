@testable import Cool
import Testing

extension VaultKeys {
  var cool: VaultKey<String> { .init("test", default: "foo") }
}

@Test func vaultBasic() async throws {
  // worth noting that the defaults suite ends up being `swiftpm-testing-helper` here
  // FIXME: test the default value, which is tricky because tests might run
  // FIXME: async/we can't enforce control of the default like that
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

@Test func truncation() {
  #expect("heya".truncating(toOverallMaxLength: 2) == "h…")
  #expect("heya".truncating(toOverallMaxLength: 4) == "heya")
  #expect("heya! nice".truncating(toOverallMaxLength: 4) == "hey…")
}

@Test func padding() {
  #expect("hi".padded(toMinLength: 4) == "hi  ")
  #expect("hi".padded(toMinLength: 4, addingFillTo: .start) == "  hi")
  #expect("hi".padded(toMinLength: 2) == "hi")
}
