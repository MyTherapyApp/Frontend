class Failure implements Exception {
  final int statusCode;
  final String message;

  const Failure({
    required this.statusCode,
    required this.message,
  });
}