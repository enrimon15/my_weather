//custom http exception
class HttpException implements Exception {
  final String _message;

  HttpException(this._message);

  @override
  String toString() {
    return _message;
  }

  String get getMessage => _message;
}