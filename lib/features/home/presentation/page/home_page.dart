import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/config/colors/app_colors.dart';
import 'package:task_management/config/theme/app_theme_text_style.dart';
import 'package:task_management/core/constants/app_constants.dart';
import 'package:task_management/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_management/features/home/presentation/widget/task_card.dart';
import 'package:task_management/features/login/presentation/widgets/clipper.dart';
import 'package:task_management/features/login/presentation/widgets/clipper_2.dart';
import 'package:task_management/features/task/presentation/page/task_page.dart';
import 'package:task_management/shared/model/task_entity.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = GetIt.I.get<HomeBloc>();

  @override
  void initState() {
    super.initState();

    _bloc.add(GetTaskEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 300),
              painter: RPSCustomPainter(),
            ),
            Positioned(
              top: 16,
              right: -5,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: RPCustomPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  Text(
                    AppConstants.taskManagement,
                    style: AppThemeTextStyle.museoSans900.copyWith(
                      fontSize: 35,
                      color: AppColors.darkBackground,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      bloc: _bloc,
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) {
                        List<TaskEntity> tasks = [];

                        if (state is HomeSuccess) {
                          tasks = state.tasks;
                        }

                        if (tasks.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: tasks.length,
                          padding: const EdgeInsets.only(bottom: 24),
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: tasks[index],
                              onTap: () => {
                                _openCardSelectedMore(
                                  context,
                                  index: index,
                                  tasks: tasks,
                                ),
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.add_task_outlined,
            color: Colors.white,
          ),
          onPressed: () => _goToTaskPage(context, isUpdate: false),
        ),
      ),
    );
  }

  void _openCardSelectedMore(
    BuildContext context, {
    required int index,
    required List<TaskEntity> tasks,
  }) async {
    await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(
                AppConstants.edit,
                style: AppThemeTextStyle.museoSans500,
              ),
              onTap: () {
                Navigator.of(context).pop();
                _goToTaskPage(
                  context,
                  isUpdate: true,
                  task: tasks[index],
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text(
                AppConstants.delete,
                style: AppThemeTextStyle.museoSans500,
              ),
              onTap: () {
                Navigator.of(context).pop();
                _bloc.add(
                  DeleteTaskEvent(
                    tasks[index].id,
                    tasks,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _goToTaskPage(
    BuildContext context, {
    required bool isUpdate,
    TaskEntity? task,
  }) async {
    final args = {
      'task': task,
    };

    await Navigator.of(context)
        .pushNamed(
          TaskPage.id,
          arguments: args,
        )
        .then(
          (_) => refreshPage(),
        );
  }

  void refreshPage() {
    _bloc.add(GetTaskEvent());
  }
}
