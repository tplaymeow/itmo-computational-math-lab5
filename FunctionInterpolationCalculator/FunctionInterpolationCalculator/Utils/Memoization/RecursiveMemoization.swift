func recursiveMemoize<Storage: MemoizationStorage>(
  storage: Storage.Type,
  recursiveFunction: @escaping (
    (Storage.Input) -> Storage.Output, Storage.Input
  ) -> Storage.Output
) -> (Storage.Input) -> Storage.Output {
  var storage = storage.init()
  return fixedPoint { function, input in
    if let cached = storage[input] {
      return cached
    } else {
      let output = recursiveFunction(function, input)
      storage[input] = output
      return output
    }
  }
}

func recursiveMemoize<Input: Hashable, Output>(
  recursiveFunction: @escaping ((Input) -> Output, Input) -> Output
) -> (Input) -> Output {
  recursiveMemoize(
    storage: DictionaryStorage.self,
    recursiveFunction: recursiveFunction
  )
}
