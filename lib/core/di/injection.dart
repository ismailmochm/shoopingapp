import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../data/sources/product_remote_source.dart';
import '../../data/repositories/product_repository.dart';
import '../../presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

void setupDI() {
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => ProductRemoteSource(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerFactory(() => ProductBloc(sl()));
}
