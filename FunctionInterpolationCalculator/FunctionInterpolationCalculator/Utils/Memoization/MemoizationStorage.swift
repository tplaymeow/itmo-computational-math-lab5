protocol MemoizationStorage<Input, Output> {
  associatedtype Input
  associatedtype Output
  init()
  subscript(input: Input) -> Output? { get set }
}

struct DictionaryStorage<Input: Hashable, Output>: MemoizationStorage {
  subscript(input: Input) -> Output? {
    get { self.dictionary[input] }
    set { self.dictionary[input] = newValue }
  }

  private var dictionary: [Input: Output] = [:]
}
