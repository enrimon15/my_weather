//custom http exception
class DbException implements Exception {
  final String _message;

  DbException(this._message);

  @override
  String toString() {
    return _message;
  }

  String get getMessage => _message;
}