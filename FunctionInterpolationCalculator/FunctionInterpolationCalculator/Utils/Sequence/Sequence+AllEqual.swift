extension Collection {
  func allEquals(
    _ predicate: (Element, Element) throws -> Bool
  ) rethrows -> Bool {
    try self.dropFirst().allSatisfy {
      try predicate(self.first!, $0)
    }
  }
}

extension Collection where Element: Equatable {
  func allEquals() -> Bool {
    self.allEquals(==)
  }
}
