import 'package:desk/widgets/dashboard_widget.dart';
import 'package:desk/widgets/side_menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import 'dto/Task.dart';
import 'dto/User.dart';

class DashboardScreen extends StatefulWidget {
  final User user;

  DashboardScreen({required this.user});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Task> tasks = List.empty();
  @override
  void initState() {
    super.initState();
    fetchTasks();
  }
  Future<void> fetchTasks() async {
    final url = Uri.parse('http://gdp-web-api.somee.com/api/Task/usertasks/${widget.user.id}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Imprime la respuesta recibida del servidor
        print(response.body);

        // Parsea la respuesta JSON a una lista de tareas
        tasks = (json.decode(response.body) as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();

        // Imprime las tareas parseadas
        tasks.forEach((task) {
          print('Tarea: ${task.title}');
          print('Descripción: ${task.description}');
          // Imprime los demás detalles de la tarea...
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción: $e');
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 2
              ,child: SizedBox(
                child: SideMenuWidget(user: widget.user),
              )
              )    ,
              Expanded(
                flex: 7,
                child: FutureBuilder<void>(
                  future: fetchTasks(), // Espera a que se completen las tareas
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Muestra un indicador de carga mientras se obtienen las tareas
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Maneja errores de obtención de tareas
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      // Construye el widget Dashboard con las tareas obtenidas
                      return Dashboard(tasks: tasks);
                    }
                  },
                ),
              ),
            ],
          ))
    );
  }

}