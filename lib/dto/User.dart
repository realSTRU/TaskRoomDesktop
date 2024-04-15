import 'package:desk/dto/Project.dart';
import 'package:desk/dto/Task.dart';


class User {
  final dynamic id;
  final String username;
  final String password;
  final String email;
  final String name;
  final String surname;
  List<Project> projects;
  List<Task> tasks;

  User({
    this.id,
    this.username = "",
    this.password = "",
    this.email = "",
    this.name = "",
    this.surname = "",
    List<Project>? projects,
    List<Task>? tasks,
  })  : projects = projects ?? [],
        tasks = tasks ?? [];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'] ?? "",
      password: json['password'] ?? "",
      email: json['email'] ?? "",
      name: json['name'] ?? "",
      surname: json['surname'] ?? "",
      projects: json['projects'] != null
          ? List<Project>.from(
          json['projects'].map((project) => Project.fromJson(project)))
          : [],
      tasks: json['tasks'] != null
          ? List<Task>.from(json['tasks'].map((task) => Task.fromJson(task)))
          : [],
    );
  }
}
