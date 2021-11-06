import 'package:get_it/get_it.dart';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

import 'injector.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(sl);

@module
abstract class RegisterModule {
  http.Client get client => http.Client();
}
