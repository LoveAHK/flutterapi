

import 'package:conduit_core/conduit_core.dart';
import 'package:dartapi/model/user.dart';

class Task extends ManagedObject<_Task> implements _Task {}

class _Task {
  @primaryKey
  int? id;


  @Column(unique: false, indexed: true)
  String? description;

  @Column(unique: false, indexed: true)
  String? tag;

  @Column(unique: false, indexed: true)
  DateTime? dateTask;

  @Relate(#taskList, isRequired: true, onDelete: DeleteRule.cascade)
  User? user;
}