import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/datasources/privacy_policy.remote.datasrc.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/domain/entity/privacy_policy.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/domain/repo/privacy_policy.repo.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

final privacyPolicyRepositoryProvider = Provider<PrivacyPolicyRepository>(
  (ref) => PrivacyPolicyRepositoryImpl(
    ref.watch(privacyPolicyRemoteDatasourceProvider),
  ),
);

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  const PrivacyPolicyRepositoryImpl(this._remoteDatasource);
  final PrivacyPolicyRemoteDatasource _remoteDatasource;
  @override
  ResultStream<PrivacyPolicy?> watchPrivacyPolicy() {
    try {
      return _remoteDatasource.watchPrivacyPolicy().map((privacy) {
        return Right(privacy?.toEntity());
      });
    } on ServerException catch (e) {
      return Stream.value(
        Left(ServerFailure.fromException(e)),
      );
    }
  }
}
