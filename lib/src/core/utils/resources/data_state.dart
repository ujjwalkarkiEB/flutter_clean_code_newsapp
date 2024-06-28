/// wrapper class for network calls
abstract class DataState<T, E> {
  DataState({this.data, this.error});
  final T? data;
  final E? error;
}

class DataSucces<T, E> extends DataState<T, E> {
  DataSucces(T data) : super(data: data);
}

class DataError<T, E> extends DataState<T, E> {
  DataError(E error) : super(error: error);
}
