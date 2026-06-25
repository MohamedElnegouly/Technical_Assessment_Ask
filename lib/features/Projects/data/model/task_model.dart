class TaskModel {
  final String id;
  final String projectId;
  final String title;
  final String status;
  final String priority;

  TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    required this.status,
    required this.priority,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'].toString(),
      projectId: json['projectId'].toString(),
      title: json['title'] ?? '',
      status: json['status'] ?? 'Pending',
      priority: json['priority'] ?? 'Medium',
    );
  }
}
