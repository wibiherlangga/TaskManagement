import 'package:task_management/core/constants/app_constants.dart';

enum EnumTaskStatus {
  pending,

  inProgress,

  completed,
}

extension EnumTaskStatusExtension on EnumTaskStatus {
  String get name {
    switch (this) {
      case EnumTaskStatus.pending:
        return AppConstants.pending;
      case EnumTaskStatus.inProgress:
        return AppConstants.inProgress;
      case EnumTaskStatus.completed:
        return AppConstants.completed;
    }
  }
}
