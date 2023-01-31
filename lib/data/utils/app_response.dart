class AppResponse<T extends Object> {
  final bool hasError;
  final T? data;
  final String? message;

  AppResponse({
    required this.hasError,
    required this.data,
    required this.message,
  });
}
