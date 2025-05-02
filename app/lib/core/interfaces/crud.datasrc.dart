import 'package:pleasehiretolga/core/interfaces/id_holder.dart';

abstract class CrudDatasource<I extends IdHolder> {
  Stream<List<I>> watchAll();

  Future<List<I>> getAll();

  Future<I?> get(String id);

  Stream<I?> watch(String id);

  Future<void> set(I item);

  Future<void> delete(String id);
}
