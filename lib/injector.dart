import 'package:get_it/get_it.dart';
import 'package:task_management/features/home/data/data_source/home_local_data_source.dart';
import 'package:task_management/features/home/data/repository/home_repository_impl.dart';
import 'package:task_management/features/home/domain/repository/home_repository.dart';
import 'package:task_management/features/home/domain/usecase/home_usecase.dart';
import 'package:task_management/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_management/features/login/data/data_source/remote/login_data_source.dart';
import 'package:task_management/features/login/data/repository/login_repository_impl.dart';
import 'package:task_management/features/login/domain/repository/login_repository.dart';
import 'package:task_management/features/login/domain/usecase/login_usecase.dart';
import 'package:task_management/features/login/presentation/bloc/login_bloc.dart';
import 'package:task_management/features/task/data/data_source/local/task_local_data_source.dart';
import 'package:task_management/features/task/data/repository/task_repository_impl.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';
import 'package:task_management/features/task/domain/usecase/task_usecase.dart';
import 'package:task_management/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_management/network/dio_client.dart';

GetIt sl = GetIt.instance;

Future<void> initDepedencies() async {
  // Data Sources
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<LoginDataSource>(LoginDataSourceImpl(sl()));
  sl.registerSingleton<TaskLocalDataSource>(TaskLocalDataSourceImpl());
  sl.registerSingleton<HomeLocalDataSource>(HomeLocalDataSourceImpl());

  // Repositories
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl()));
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl()));
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<TaskUseCase>(TaskUseCase(sl()));
  sl.registerSingleton<HomeUseCase>(HomeUseCase(sl()));

  // Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl()),
  );

  sl.registerFactory<TaskBloc>(
    () => TaskBloc(sl()),
  );

  sl.registerFactory<HomeBloc>(
    () => HomeBloc(sl()),
  );
}
