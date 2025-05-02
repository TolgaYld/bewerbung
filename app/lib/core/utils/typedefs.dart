import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
