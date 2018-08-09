
class Result<T> {
  int code;
  T data;
  String message;

  Result({this.code, this.data, this.message});

  bool isSuccess() {
    return code == 200;
  }
}