import 'package:pleasehiretolga/core/features/imprint/domain/entity/imprint.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

abstract interface class ImprintRepository {
  ResultStream<Imprint?> watchImprint();
}
