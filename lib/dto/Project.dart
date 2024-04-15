import 'Participant.dart';
import 'Task.dart';
class Project {
  final dynamic id;
  final String title;
  final String descripcion;
  final String status;
  final String startDate;
  final String endDate;
  final String note;
  final dynamic creatorId;
  List<Participant> participants;
  List<Task> tasks;

  Project({
    this.id,
    this.title = "",
    this.descripcion = "",
    this.status = "",
    this.startDate = "",
    this.endDate = "",
    this.note = "",
    this.creatorId,
    List<Participant>? participants,
    List<Task>? tasks,
  })  : participants = participants ?? [],
        tasks = tasks ?? [];

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'] ?? "",
      descripcion: json['descripcion'] ?? "",
      status: json['status'] ?? "",
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? "",
      note: json['note'] ?? "",
      creatorId: json['creatorId'],
      participants: json['participants'] != null
          ? List<Participant>.from(json['participants'].map((participant) => Participant.fromJson(participant)))
          : [],
      tasks: json['tasks'] != null
          ? List<Task>.from(json['tasks'].map((task) => Task.fromJson(task)))
          : [],
    );
  }
}