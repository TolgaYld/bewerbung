import 'package:dart_mappable/dart_mappable.dart';

part 'exception.mapper.dart';

@MappableClass()
class ServerException with ServerExceptionMappable implements Exception {
  ServerException({
    required this.message,
    this.isUnknownException = false,
    this.statusCode,
  });

  final String message;
  final bool isUnknownException;
  final String? statusCode;
}
