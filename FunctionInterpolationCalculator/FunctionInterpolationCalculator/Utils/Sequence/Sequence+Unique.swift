extension Sequence {
  func unique<T: Hashable>(
    for keyPath: KeyPath<Element, T>
  ) -> [Element] {
    var elements = Set<T>()
    return self.filter { elements.insert($0[keyPath: keyPath]).inserted }
  }
}

extension Sequence where Element: Hashable {
  func unique() -> [Element] {
    self.unique(for: \.self)
  }
}
