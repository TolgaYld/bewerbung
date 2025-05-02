import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/core/interfaces/crud.datasrc.dart';
import 'package:pleasehiretolga/core/interfaces/id_holder.dart';

abstract class CrudFirestoreDatasrc<M extends IdHolder>
    implements CrudDatasource<M> {
  CollectionReference<M> get collectionReference;

  @override
  Future<void> set(M data) async =>
      await collectionReference.doc(data.id).set(data, SetOptions(merge: true));

  @override
  Future<void> delete(String id) async =>
      await collectionReference.doc(id).delete();

  @override
  Future<List<M>> getAll() async => await collectionReference
      .get()
      .then((snap) => snap.docs.map((e) => e.data()).toList());

  @override
  Future<M?> get(String id) async =>
      await collectionReference.doc(id).get().then((snap) => snap.data());

  @override
  Stream<List<M>> watchAll() => collectionReference
      .snapshots()
      .map((snap) => snap.docs.map((e) => e.data()).toList());

  @override
  Stream<M?> watch(String id) =>
      collectionReference.doc(id).snapshots().map((snap) => snap.data());
}
