import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';
import 'package:pleasehiretolga/features/decision/data/datasources/decision.remote.datasource.dart';
import 'package:pleasehiretolga/features/decision/data/models/decision_update.model.dart';
import 'package:pleasehiretolga/features/decision/domain/repo/decision.repo.dart';

final decisionRepoProvider = Provider<DecisionRepo>((ref) {
  final remoteDataSource = ref.watch(decisionRemoteDatasourceProvider);
  return DecisionRepoImpl(remoteDataSource);
});

class DecisionRepoImpl implements DecisionRepo {
  const DecisionRepoImpl(this._remoteDataSource);

  final DecisionRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> revertDecision(String employeeId) async {
    try {
      await _remoteDataSource.revertDecision(employeeId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateDecision({
    required String employeeId,
    DecisionStatus? status,
    String? decisionMessage,
    DateTime? inviteDate,
    Duration? inviteDuration,
  }) async {
    try {
      final decisionUpdateModel = DecisionUpdateModel(
        id: employeeId,
        decisionStatus: status,
        decisionMessage: decisionMessage,
        inviteDate: inviteDate,
        inviteDurationInMinutes: inviteDuration?.inMinutes,
      );

      await _remoteDataSource.updateDecision(decisionUpdateModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
