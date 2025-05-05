import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/imprint/data/datasources/imprint.remote.datasrc.dart';
import 'package:pleasehiretolga/core/features/imprint/domain/entity/imprint.dart';
import 'package:pleasehiretolga/core/features/imprint/domain/repo/imprint.repo.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

final imprintRepositoryProvider = Provider<ImprintRepository>(
  (ref) => ImprintRepoImpl(
    ref.watch(imprintRemoteDatasourceProvider),
  ),
);

class ImprintRepoImpl implements ImprintRepository {
  const ImprintRepoImpl(this._remoteDatasource);
  final ImprintRemoteDatasource _remoteDatasource;
  @override
  ResultStream<Imprint?> watchImprint() {
    try {
      return _remoteDatasource.watchImprint().map((imprint) {
        return Right(imprint?.toEntity());
      });
    } on ServerException catch (e) {
      return Stream.value(
        Left(ServerFailure.fromException(e)),
      );
    }
  }
}
