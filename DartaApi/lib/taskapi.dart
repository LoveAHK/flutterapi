import 'dart:io';

import 'package:conduit_core/conduit_core.dart';
import 'package:dartapi/model/user.dart';
import 'controllers/task_controller.dart';
import 'model/user.dart';
import 'model/task.dart';
import 'dart:async';
import 'controllers/auth_controller.dart';
import 'controllers/token_contriller.dart';
import 'controllers/user_controller.dart';
import 'package:conduit_postgresql/conduit_postgresql.dart';
class AppService extends ApplicationChannel{
late final ManagedContext managedContext;

@override
  Future prepare() {
    final persistentStore =_initDataBase();
     managedContext=ManagedContext(ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);
    // TODO: implement prepare
    return super.prepare();
  }





  @override
  // TODO: implement entryPoint
  Controller get entryPoint => Router()
      ..route('token/[:refresh]')
        .link(() => AppAuthContoler(managedContext))
      ..route('user').link(AppTokenContoller.new)!
        .link(() => AppUserConttolelr(managedContext))
      ..route('task').link(AppTokenContoller.new)!
        .link(() => AppTaskConttolelr(managedContext));


  PersistentStore _initDataBase(){
    final username = Platform.environment['DB_USERNAME']??'postgres';
    final password = Platform.environment['DB_PASSWORD']??'9635';
    final host = Platform.environment['DB_HOST']??'127.0.0.1';
    final port =int.parse(Platform.environment['DB_PORT']??'5432');
    final databaseName =Platform.environment['DB_NAME']??'postgres';
    return PostgreSQLPersistentStore(username, password, host, port, databaseName);
  }

  
}