class ConfigurationException {
  final String _message;

  ConfigurationException(this._message);

  @override
  String toString() {
    return _message;
  }

  String get getMessage => _message;
}