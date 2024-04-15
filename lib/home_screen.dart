import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Cesar Dev'),
              accountEmail: Text('cesar.dev@example.com'),
              currentAccountPicture: CircleAvatar(
                child: Text('C'), // Muestra la inicial del nombre del usuario
              ),
            ),
            ListTile(
              title: Text('Opción 1'),
              onTap: () {
                // Manejar la acción de la opción 1
              },
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {
                // Manejar la acción de la opción 2
              },
            ),
            // Agrega más opciones de menú según sea necesario
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Contenido de la pantalla aquí'),
          ],
        ),
      ),
    );
  }
}
