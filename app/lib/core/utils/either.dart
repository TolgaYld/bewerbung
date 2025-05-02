sealed class Either<L, R> {
  const Either._();
}

class Left<L, R> extends Either<L, R> {
  const Left(this.failure) : super._();

  final L failure;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Left && other.failure == failure;
  }

  @override
  int get hashCode => failure.hashCode;
}

class Right<L, R> extends Either<L, R> {
  const Right(this.value) : super._();

  final R value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Right && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
