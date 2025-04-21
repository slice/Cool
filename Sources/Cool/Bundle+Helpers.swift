import Foundation

// https://developer.apple.com/documentation/bundleresources/placing-content-in-a-bundle#Place-content-based-on-type-and-platform
// https://github.com/jerrykrinock/CategoriesObjC/blob/8deeb5be1e15744b8877ca55940d31a3daf85b26/NSBundle%2BHelperPaths.h#L19-L44
public extension Bundle {
  func url(forHelperExecutable executableName: String) -> URL {
    bundleURL
      .appendingPathComponent("Contents", isDirectory: true)
      .appendingPathComponent("Helpers", isDirectory: true)
      .appendingPathComponent(executableName, isDirectory: false)
  }

  func path(forHelperExecutable executableName: String) -> String {
    url(forHelperExecutable: executableName).path
  }
}
