class SearchParseException {
  final String _message;

  SearchParseException(this._message);

  @override
  String toString() {
    return _message;
  }

  String get getMessage => _message;
}