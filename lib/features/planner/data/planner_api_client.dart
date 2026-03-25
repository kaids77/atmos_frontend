import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atmos_frontend/core/config/api_config.dart';
import 'package:atmos_frontend/features/planner/domain/planner_models.dart';

class PlannerApiClient {

  // ── Board (Plan) operations ──

  Future<PlannerBoard> createBoard(String name, String description, String userId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/planner/boards');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'description': description, 'userId': userId}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return PlannerBoard.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create plan');
  }

  Future<List<PlannerBoard>> getBoards(String userId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/planner/boards?userId=$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => PlannerBoard.fromJson(e)).toList();
    }
    throw Exception('Failed to load plans');
  }

  Future<void> deleteBoard(String boardId, String userId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/planner/boards/$boardId?userId=$userId');
    final response = await http.delete(url);
    if (response.statusCode != 200) throw Exception('Failed to delete plan');
  }

  // ── Task operations ──

  Future<PlannerTask> createTask(PlannerTask task, String userId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/planner/tasks');
    final payload = task.toJson();
    payload.remove('id');
    payload['userId'] = userId;

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return PlannerTask.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create task');
  }

  Future<List<PlannerTask>> getTasks(String userId, {String? boardId}) async {
    String urlStr = '${ApiConfig.baseUrl}/api/planner/tasks?userId=$userId';
    if (boardId != null) urlStr += '&boardId=$boardId';
    final url = Uri.parse(urlStr);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => PlannerTask.fromJson(e)).toList();
    }
    throw Exception('Failed to load tasks');
  }

  Future<PlannerTask> updateTask(PlannerTask task, String userId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/planner/tasks/${task.id}?userId=$userId');
    final payload = task.toJson();
    payload.remove('id');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );
    if (response.statusCode == 200) {
      return PlannerTask.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to update task');
  }

  Future<void> deleteTask(String taskId, String userId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/planner/tasks/$taskId?userId=$userId');
    final response = await http.delete(url);
    if (response.statusCode != 200) throw Exception('Failed to delete task');
  }
}
