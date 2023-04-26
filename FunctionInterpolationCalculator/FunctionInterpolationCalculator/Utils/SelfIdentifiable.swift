protocol SelfIdentifiable: Hashable, Identifiable { }

extension SelfIdentifiable {
  var id: Self {
    self
  }
}
