class ServerException implements Exception {
  final int? statusCode;
  final String message;

  const ServerException({required this.message, this.statusCode});
}
