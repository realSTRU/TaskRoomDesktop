import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../app_colors.dart';
import '../app_styles.dart';
import '../dto/Task.dart';
import '../dto/User.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final IconData defaultIcon;

  TaskCard({Key? key, required this.task, required this.defaultIcon})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late int _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.task.status;
  }

  // Método para realizar la actualización
  Future<void> _updateTask() async {
    final url = Uri.parse('http://gdp-web-api.somee.com/api/Task/update');
    print('Tarea a actualizar:');
    print(widget.task);
    print(json.encode(widget.task.toJson()));
    print("id${widget.task.id}");
    print("id${widget.task.description}");
    print("id${widget.task.title}");
    print("id${widget.task.note}");
    print("id${widget.task.status}");
    print("id${widget.task.endDate}");
    print("id${widget.task.startDate}");
    print("id${widget.task.projectId}");
    print("id${widget.task.userId}");
    final response = await http.put(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(widget.task.toJson()),);
    print(response.body);
    if (response.statusCode == 200) {
      // Actualización exitosa, puedes realizar alguna acción adicional si lo deseas
      print('Tarea actualizada exitosamente');
    } else {
      // Manejar el caso de error si la actualización falla
      print('Error al actualizar la tarea: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStrings = {
      0: 'Iniciado',
      1: 'Estancado',
      2: 'Completado',
    };

    final statusColors = {
      'Iniciado': AppColors.startedTaskColor,
      'Estancado': AppColors.redDarkColor,
      'Completado': AppColors.greenTaskColor,
    };

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 10,
      borderOnForeground: true,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(widget.defaultIcon, size: 24),
                    SizedBox(width: 8),
                    Text(
                      widget.task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColors[statusStrings[_selectedStatus]!],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusStrings[_selectedStatus]!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Started: ${widget.task.startDate}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "End: ${widget.task.endDate}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'Note'),
              controller: TextEditingController(text: widget.task.note),
              onChanged: (value) {
                widget.task.note = value;
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: statusStrings[_selectedStatus]!,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = statusStrings.entries
                          .firstWhere(
                              (entry) => entry.value == newValue,
                          orElse: () => MapEntry(-1, 'Desconocido'))
                          .key;
                      widget.task.status = _selectedStatus;
                    });
                  },
                  items: statusStrings.values
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: statusColors[value]),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: (){_updateTask;
                  toastification.show(
                    context: context,
                    title: Text('La tarea: ${widget.task.title} ha sido actualizada!'),
                    type: ToastificationType.info,
                    style: ToastificationStyle.minimal,
                    autoCloseDuration: const Duration(seconds: 5),
                  );

                  },
                  child: Text(
                    'Actualizar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );





  }
}

class Dashboard extends StatelessWidget {
  final List<Task> tasks;

  Dashboard({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      print('No hay tareas');
    }
    tasks.forEach((task) {
      print('Tarea: ${task.title}');
      print('Descripción: ${task.description}');
      print('Estado: ${task.status}');
      print('Fecha de inicio: ${task.startDate}');
      print('Fecha de finalización: ${task.endDate}');
      print('Nota: ${task.note}');
      print('---');
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: ralewayStyle.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.orangeColor,
          ),
        ),
        backgroundColor: AppColors.darkBackColor,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            IconData defaultIcon = Icons.event;
            return TaskCard(task: tasks[index], defaultIcon: defaultIcon);
          },
        ),
      ),
    );
  }
}

