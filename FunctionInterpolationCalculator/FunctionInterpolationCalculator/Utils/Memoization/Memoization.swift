func memoize<Storage: MemoizationStorage>(
  storage: Storage.Type,
  function: @escaping (Storage.Input) -> Storage.Output
) -> (Storage.Input) -> Storage.Output {
  var storage = storage.init()
  return { input in
    if let cached = storage[input] {
      return cached
    } else {
      let output = function(input)
      storage[input] = output
      return output
    }
  }
}

func memoize<Input: Hashable, Output>(
  function: @escaping (Input) -> Output
) -> (Input) -> Output {
  memoize(
    storage: DictionaryStorage.self,
    function: function
  )
}
