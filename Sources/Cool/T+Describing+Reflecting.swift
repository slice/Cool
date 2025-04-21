postfix operator %

public postfix func % (thing: some Any) -> String {
  String(describing: thing)
}

postfix operator %!

public postfix func %! (thing: some Any) -> String {
  String(reflecting: thing)
}
