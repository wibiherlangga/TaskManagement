import 'package:get_it/get_it.dart';
import 'package:task_management/features/login/data/data_source/remote/login_data_source.dart';
import 'package:task_management/features/login/data/repository/login_repository_impl.dart';
import 'package:task_management/features/login/domain/repository/login_repository.dart';
import 'package:task_management/features/login/domain/usecase/login_usecase.dart';
import 'package:task_management/features/login/presentation/bloc/login_bloc.dart';
import 'package:task_management/network/dio_client.dart';

GetIt sl = GetIt.instance;

Future<void> initDepedencies() async {
  // Data Sources
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<LoginDataSource>(LoginDataSourceImpl(sl()));

  // Repositories
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));

  // Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl()),
  );
}
