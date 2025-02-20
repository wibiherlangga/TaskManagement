import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:task_management/config/colors/app_colors.dart';
import 'package:task_management/config/theme/app_theme_text_style.dart';
import 'package:task_management/core/constants/app_constants.dart';
import 'package:task_management/core/enums/enum_task_status.dart';
import 'package:task_management/core/mixin/snack_bar_mixin.dart';
import 'package:task_management/features/task/domain/entity/task_input_model.dart';
import 'package:task_management/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_management/shared/custom/app_button.dart';
import 'package:task_management/shared/custom/app_textfield.dart';
import 'package:task_management/shared/model/task_entity.dart';

class TaskPage extends StatefulWidget {
  static const String id = 'TaskPage';
  final TaskEntity? task;

  const TaskPage({
    super.key,
    this.task,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with SnackBarMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _taskTitleController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final TextEditingController _taskDateController = TextEditingController();

  final List<EnumTaskStatus> taskStatus = [
    EnumTaskStatus.pending,
    EnumTaskStatus.inProgress,
    EnumTaskStatus.completed,
  ];

  EnumTaskStatus taskStatusSelected = EnumTaskStatus.pending;

  final _bloc = GetIt.I.get<TaskBloc>();

  void _setUpdateFields() {
    final task = widget.task;
    if (task == null) return;

    _taskTitleController.text = task.title;
    _taskDescriptionController.text = task.description;
    _taskDateController.text = task.date;
    taskStatusSelected = task.status;
  }

  @override
  void initState() {
    super.initState();
    _setUpdateFields();
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    _taskDateController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>.value(
      value: _bloc,
      child: BlocListener<TaskBloc, TaskState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is SnackBarStateError) {
            showErrorSnackBar(context, message: state.message);
          } else if (state is SnackBarStateSuccess) {
            showSuccessSnackBar(
              context,
              message: state.message,
              onClosed: () => _goToHomePage(context),
            );
          } else {
            removeSnackBar(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: const Text(
              AppConstants.task,
              style: AppThemeTextStyle.museoSans500,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        _taskTitleTextField(context),
                        const SizedBox(height: 24),
                        _taskDescriptionTextField(context),
                        const SizedBox(height: 24),
                        _taskDateTextField(context),
                        const SizedBox(height: 24),
                        _taskStatusDropDown(context),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                      title: widget.task != null
                          ? AppConstants.update
                          : AppConstants.add,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _addTask();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskTitleTextField(BuildContext context) {
    return AppTextfield(
      context: context,
      controller: _taskTitleController,
      title: AppConstants.taskTitle,
      hint: AppConstants.taskTitleHint,
      isAterisk: true,
      prefixIcon: Icons.title_sharp,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppConstants.taskTitleEmpty;
        }

        return null;
      },
      onChanged: (value) {
        _formKey.currentState?.validate();
      },
    );
  }

  Widget _taskDescriptionTextField(BuildContext context) {
    return AppTextfield(
      context: context,
      controller: _taskDescriptionController,
      title: AppConstants.taskDescription,
      hint: AppConstants.taskDescriptionHint,
      isAterisk: false,
      prefixIcon: Icons.description_outlined,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      onChanged: (value) {
        _formKey.currentState?.validate();
      },
    );
  }

  Widget _taskDateTextField(BuildContext context) {
    return AppTextfield(
      context: context,
      controller: _taskDateController,
      title: AppConstants.taskDate,
      hint: AppConstants.taskDateHint,
      isAterisk: true,
      readOnly: true,
      prefixIcon: Icons.edit_calendar_sharp,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppConstants.taskDateEmpty;
        }

        return null;
      },
      onTap: () => _showDatePicker(context),
      onChanged: (value) {
        _formKey.currentState?.validate();
      },
    );
  }

  Widget _taskStatusDropDown(BuildContext context) {
    return DropdownButtonFormField<EnumTaskStatus>(
      value: taskStatusSelected,
      icon: const Icon(Icons.arrow_drop_down),
      dropdownColor: Colors.white,
      focusColor: AppColors.primary,
      isDense: false,
      decoration: InputDecoration(
        labelText: AppConstants.taskStatus,
        labelStyle: AppThemeTextStyle.museoSans300.copyWith(
          color: AppColors.primary,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE8E8E8)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
      items: taskStatus.map((status) {
        return DropdownMenuItem(
          value: status,
          child: Text(status.name),
        );
      }).toList(),
      onChanged: (EnumTaskStatus? newValue) {
        if (newValue != null) {
          setState(() {
            taskStatusSelected = newValue;
          });
        }
      },
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime nextYear = now.add(const Duration(days: 30));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: nextYear,
    );

    if (pickedDate != null) {
      String formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(pickedDate);
      setState(() {
        _taskDateController.text = formattedDate;
        _formKey.currentState?.validate();
      });
    }
  }

  void _goToHomePage(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _addTask() {
    final TaskInputModel task = TaskInputModel(
      title: _taskTitleController.text,
      description: _taskDescriptionController.text,
      date: _taskDateController.text,
      status: taskStatusSelected,
    );

    if (widget.task != null) {
      _bloc.add(
        UpdateTaskEvent(task),
      );
    } else {
      _bloc.add(
        AddTaskEvent(task),
      );
    }
  }
}
