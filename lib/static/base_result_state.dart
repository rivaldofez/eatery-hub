sealed class ResultState<T> {}

class NoneState<T> extends ResultState<T> {}

class LoadingState<T> extends ResultState<T> {}

class ErrorState<T> extends ResultState<T> {
  final String error;

  ErrorState(this.error);
}

class LoadedState<T> extends ResultState<T> {
  final T data;

  LoadedState(this.data);
}