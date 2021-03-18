import 'package:app_movie/service/base_provider.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setLocator() {
  locator.registerLazySingleton(() => BaseApiProvider());
  locator.registerLazySingleton(() => ProviderAPI());
}