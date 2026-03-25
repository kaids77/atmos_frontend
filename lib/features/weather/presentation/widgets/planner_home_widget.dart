import 'package:flutter/material.dart';
import 'package:atmos_frontend/core/auth/auth_state.dart';
import 'package:atmos_frontend/features/planner/domain/planner_models.dart';
import 'package:atmos_frontend/features/planner/data/planner_repository.dart';

class PlannerHomeWidget extends StatefulWidget {
  final String? currentWeatherCondition;
  
  const PlannerHomeWidget({super.key, this.currentWeatherCondition});

  @override
  State<PlannerHomeWidget> createState() => _PlannerHomeWidgetState();
}

class _PlannerHomeWidgetState extends State<PlannerHomeWidget> {
  final PlannerRepository _repository = PlannerRepository();
  List<PlannerTask> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final userId = AuthState().userEmail;
    if (userId == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    try {
      // Fetch all tasks across all boards (no boardId filter)
      final tasks = await _repository.getTasks(userId);
      if (mounted) {
        setState(() {
          _tasks = tasks.where((t) => t.status != 'done').toList();
          _tasks.sort((a, b) {
            if (a.dueDate != null && b.dueDate == null) return -1;
            if (a.dueDate == null && b.dueDate != null) return 1;
            if (a.dueDate != null && b.dueDate != null) return a.dueDate!.compareTo(b.dueDate!);
            return 0;
          });
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  IconData _weatherIcon(String? condition) {
    if (condition == null) return Icons.wb_cloudy_outlined;
    switch (condition.toLowerCase()) {
      case 'thunderstorm': return Icons.thunderstorm;
      case 'rain': return Icons.water_drop;
      case 'snow': return Icons.ac_unit;
      case 'clear': return Icons.wb_sunny;
      case 'clouds': return Icons.cloud;
      default: return Icons.wb_cloudy;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!AuthState().isSignedIn) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(children: [
                Icon(Icons.assignment_outlined, size: 18, color: Color(0xFF29B6F6)),
                SizedBox(width: 6),
                Text('Upcoming Plans', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              ]),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/planner').then((_) => _fetchTasks()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF29B6F6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('View All', style: TextStyle(color: Color(0xFF29B6F6), fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (_isLoading)
            const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF29B6F6))))
          else if (_tasks.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(children: [
                  Icon(Icons.event_available, color: Colors.grey.shade400, size: 32),
                  const SizedBox(height: 8),
                  Text('No upcoming tasks. You\'re all set!', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                ]),
              ),
            )
          else
            ..._tasks.take(3).map((task) => _buildTaskItem(task)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(PlannerTask task) {
    bool isWeatherMatch = false;
    if (widget.currentWeatherCondition != null && task.weatherConditionTarget != null) {
       final cw = widget.currentWeatherCondition!.toLowerCase();
       final tw = task.weatherConditionTarget!.toLowerCase();
       if (cw.contains(tw) || tw.contains(cw)) isWeatherMatch = true;
    }
    final isOverdue = task.isOverdue;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        border: isOverdue ? Border.all(color: Colors.red.shade200, width: 1) : null,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isWeatherMatch ? const Color(0xFFE8F5E9) : const Color(0xFFF0F2F5),
            shape: BoxShape.circle,
          ),
          child: Icon(_weatherIcon(task.weatherConditionTarget), size: 16,
            color: isWeatherMatch ? Colors.green : Colors.grey.shade600),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(task.title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 14),
              maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Row(children: [
              if (task.status == 'in_progress')
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(4)),
                  child: const Text('In Progress', style: TextStyle(fontSize: 10, color: Color(0xFFFB8C00), fontWeight: FontWeight.bold)),
                ),
              if (task.dueDateFormatted != null)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.event, size: 11, color: isOverdue ? Colors.red : Colors.grey.shade500),
                  const SizedBox(width: 3),
                  Text(task.dueDateFormatted!, style: TextStyle(fontSize: 11, color: isOverdue ? Colors.red : Colors.grey.shade500)),
                ]),
            ]),
          ]),
        ),
        if (isWeatherMatch) const Icon(Icons.check_circle, color: Colors.green, size: 16)
        else if (isOverdue) Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: 16),
      ]),
    );
  }
}
