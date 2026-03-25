// ── PlannerBoard (Plan container) ──
class PlannerBoard {
  final String id;
  final String name;
  final String description;
  final int taskCount;

  PlannerBoard({
    required this.id,
    required this.name,
    this.description = '',
    this.taskCount = 0,
  });

  factory PlannerBoard.fromJson(Map<String, dynamic> json) {
    return PlannerBoard(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      taskCount: json['task_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

// ── PlannerTask (belongs to a board) ──
class PlannerTask {
  final String id;
  final String title;
  final String description;
  final String status;
  final String? weatherConditionTarget;
  final String? dueDate;
  final String? boardId;

  PlannerTask({
    required this.id,
    required this.title,
    this.description = '',
    this.status = 'todo',
    this.weatherConditionTarget,
    this.dueDate,
    this.boardId,
  });

  factory PlannerTask.fromJson(Map<String, dynamic> json) {
    return PlannerTask(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'todo',
      weatherConditionTarget: json['weather_condition_target'],
      dueDate: json['due_date'],
      boardId: json['board_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'weather_condition_target': weatherConditionTarget,
      'due_date': dueDate,
      'board_id': boardId,
    };
  }

  PlannerTask copyWith({
    String? title,
    String? description,
    String? status,
    String? weatherConditionTarget,
    String? dueDate,
    bool clearDueDate = false,
  }) {
    return PlannerTask(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      weatherConditionTarget: weatherConditionTarget ?? this.weatherConditionTarget,
      dueDate: clearDueDate ? null : (dueDate ?? this.dueDate),
      boardId: boardId,
    );
  }

  bool get isOverdue {
    if (dueDate == null || status == 'done') return false;
    try {
      final due = DateTime.parse(dueDate!);
      return DateTime.now().isAfter(due);
    } catch (_) {
      return false;
    }
  }

  String? get dueDateFormatted {
    if (dueDate == null) return null;
    try {
      final due = DateTime.parse(dueDate!);
      const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      return '${months[due.month - 1]} ${due.day}, ${due.year}';
    } catch (_) {
      return dueDate;
    }
  }
}
