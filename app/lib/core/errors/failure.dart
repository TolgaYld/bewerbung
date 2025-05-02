import 'package:dart_mappable/dart_mappable.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';

part 'failure.mapper.dart';

@MappableClass()
sealed class Failure with FailureMappable {
  Failure({
    required this.message,
    this.isUnknownException = false,
    this.statusCode,
  });

  final String message;
  final bool isUnknownException;
  final int? statusCode;
}

@MappableClass()
class ServerFailure extends Failure with ServerFailureMappable {
  ServerFailure({required super.message, super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : super(
          message: exception.message,
          isUnknownException: exception.isUnknownException,
          statusCode: int.parse(exception.statusCode ?? '505'),
        );
}
