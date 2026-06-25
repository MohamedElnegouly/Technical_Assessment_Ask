class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String status;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['_id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Active',
    );
  }
}
