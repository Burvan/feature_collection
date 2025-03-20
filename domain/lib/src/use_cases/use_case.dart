abstract class UseCase<Input, Output> {
  Future<Output> execute(Input input);
}

abstract class FutureUseCase<Output, Input> {
  Future<Output> execute(Input input);
}

abstract class StreamUseCase<Output, Input> {
  Stream<Output> execute(Input input);
}

class NoParams {
  const NoParams();
}