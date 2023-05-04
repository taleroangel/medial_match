class ContentDoesNotExistException implements Exception {
  final String? resource;

  const ContentDoesNotExistException({this.resource});

  @override
  String toString() => '$runtimeType: resource';
}
