import 'package:flutter/material.dart';
import 'package:task_management/config/colors/app_colors.dart';
import 'package:task_management/config/theme/app_theme_text_style.dart';
import 'package:task_management/core/enums/enum_task_status.dart';
import 'package:task_management/shared/model/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A121212),
                offset: Offset(1, 3),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    style: AppThemeTextStyle.museoSans900,
                  ),
                  const Icon(
                    Icons.more_horiz,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                task.description,
                style: AppThemeTextStyle.museoSans300w400.copyWith(
                  color: AppColors.grayLabel,
                ),
              ),
              const Divider(
                color: AppColors.lightBackground,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.av_timer,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      task.date,
                      style: AppThemeTextStyle.museoSans500w400,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  _taskStatusView(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskStatusView() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _getStatusViewColor(),
      ),
      child: Text(
        task.status.name,
        style: AppThemeTextStyle.museoSans500.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getStatusViewColor() {
    switch (task.status) {
      case EnumTaskStatus.pending:
        return Colors.orangeAccent;
      case EnumTaskStatus.inProgress:
        return Colors.blueAccent;
      case EnumTaskStatus.completed:
        return Colors.greenAccent;
    }
  }
}
