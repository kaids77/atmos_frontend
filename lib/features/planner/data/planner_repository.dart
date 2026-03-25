import 'package:atmos_frontend/features/planner/domain/planner_models.dart';
import 'package:atmos_frontend/features/planner/data/planner_api_client.dart';

class PlannerRepository {
  final PlannerApiClient _apiClient = PlannerApiClient();

  // ── Boards ──
  Future<PlannerBoard> createBoard(String name, String description, String userId) {
    return _apiClient.createBoard(name, description, userId);
  }

  Future<List<PlannerBoard>> getBoards(String userId) {
    return _apiClient.getBoards(userId);
  }

  Future<void> deleteBoard(String boardId, String userId) {
    return _apiClient.deleteBoard(boardId, userId);
  }

  // ── Tasks ──
  Future<PlannerTask> createTask(PlannerTask task, String userId) {
    return _apiClient.createTask(task, userId);
  }

  Future<List<PlannerTask>> getTasks(String userId, {String? boardId}) {
    return _apiClient.getTasks(userId, boardId: boardId);
  }

  Future<PlannerTask> updateTask(PlannerTask task, String userId) {
    return _apiClient.updateTask(task, userId);
  }

  Future<void> deleteTask(String taskId, String userId) {
    return _apiClient.deleteTask(taskId, userId);
  }
}
