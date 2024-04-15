class Task {
  final dynamic id;
  final dynamic projectId;
  final dynamic userId;
  final String title;
  final String description;
  int status; // Cambiado a int
  final String startDate;
  final String endDate;
  String note;

  Task({
    this.id,
    this.projectId,
    this.userId,
    this.title = "",
    this.description = "",
    required this.status, // Modificado a required
    this.startDate = "",
    this.endDate = "",
    this.note = "",
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      projectId: json['projectId'],
      userId: json['userId'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      status: json['status'], // No se necesita ?? 0, ya que se declara como int
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? "",
      note: json['note'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'userId': userId,
      'title': title,
      'description': description,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
      'note': note,
    };
  }
}