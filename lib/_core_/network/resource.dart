class Resource<T> {
  final T? data;

  Resource._(this.data);

  factory Resource.loading(T? data) => Loading(data);

  factory Resource.success(T? data) => Success(data);

  factory Resource.error({required Error? err, T? data}) =>
      Error<T>(err, err?.message, data);

  bool isSuccess() => this is Success;

  bool isLoading() => this is Loading;

  bool isError() => this is Error<T?>;
}

class Loading<T> extends Resource<T> {
  Loading(T? data) : super._(data);
}

class Success<T> extends Resource<T> {
  Success(T? data) : super._(data);
}

class Error<T> extends Resource<T> {
  final String? message;
  final dynamic? error;
  Error(this.error, this.message, T? data) : super._(data);
}
