class TodoTitle {
  final String value;

  TodoTitle._(this.value);

  factory TodoTitle(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Título não pode ser vazio.');
    }
    if (trimmed.length > 50) {
      throw ArgumentError('Título deve ter no máximo 50 caracteres.');
    }
    return TodoTitle._(trimmed);
  }

  @override
  String toString() => value;
}