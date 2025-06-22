public class Box<Boxed> {
  public var inner: Boxed

  public init(boxing value: Boxed) {
    self.inner = value
  }
}

extension Box: Equatable where Boxed: Equatable {
  public static func == (lhs: Box<Boxed>, rhs: Box<Boxed>) -> Bool {
    lhs.inner == rhs.inner
  }
}
