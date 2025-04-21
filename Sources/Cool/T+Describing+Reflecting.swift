postfix operator %

@_transparent
public postfix func % (thing: some Any) -> String {
  String(describing: thing)
}

postfix operator %!

@_transparent
public postfix func %! (thing: some Any) -> String {
  String(reflecting: thing)
}
