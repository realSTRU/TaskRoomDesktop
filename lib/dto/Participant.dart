class Participant {
  final dynamic id;
  final dynamic projectId;
  final dynamic userId;
  final dynamic roleId;

  Participant({
    this.id,
    this.projectId,
    this.userId,
    this.roleId,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      projectId: json['projectId'],
      userId: json['userId'],
      roleId: json['roleId'],
    );
  }
}
