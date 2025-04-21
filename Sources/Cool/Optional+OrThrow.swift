@usableFromInline
struct CoolError {
  private var description: String

  private var file: StaticString?
  private var line: UInt?

  @usableFromInline
  init(description: String, file: StaticString?, line: UInt?) {
    self.description = description
    self.file = file
    self.line = line
  }
}

extension CoolError: Error {
  var localizedDescription: String {
    if let file, let line {
      "\(file):\(line): \(description)"
    } else {
      description
    }
  }
}

public extension Optional {
  @_alwaysEmitIntoClient
  func orThrow<Error: Swift.Error>(_ error: Error) throws(Error) -> Wrapped {
    guard let self else { throw error }
    return self
  }

  @_alwaysEmitIntoClient
  func orThrow(_ message: String, _ file: StaticString = #file, _ line: UInt = #line) throws -> Wrapped {
    guard let self else { throw CoolError(description: message, file: file, line: line) }
    return self
  }
}
