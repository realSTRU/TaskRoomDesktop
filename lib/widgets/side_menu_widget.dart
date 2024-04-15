import 'package:desk/app_colors.dart';
import 'package:desk/app_styles.dart';
import 'package:desk/login_screen.dart';
import 'package:flutter/material.dart';

import '../data/side_menu_data.dart';
import '../dto/User.dart';

class SideMenuWidget extends StatefulWidget{
  final User user;
  const SideMenuWidget({Key? key, required this.user}) : super(key: key);
  @override
  State<SideMenuWidget> createState()=> _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget>{

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    // Datos de ejemplo del usuario


    return Container(
      color: AppColors.darkBackColor,
      child: Column(
        children: [
          // Card con información del usuario
          Card(
            color: AppColors.darkBackColor,
            elevation: 0, // Sin sombra
            margin: const EdgeInsets.all(0),
            child: ListTile(
              leading: Icon(Icons.person, color: AppColors.whiteColor),
              title: Text(
                widget.user.name,
                style: ralewayStyle.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: Text(
                widget.user.email,
                style: ralewayStyle.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
          ),
          // Separador
          //Divider(color: AppColors.whiteColor),
          // Lista de opciones del menú
          Expanded(
            child: ListView.builder(
              itemCount: data.menu.length,
              itemBuilder: (context, index) => buildMenuEntry(data, index),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index){
    final isSelected = selectedIndex ==index;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0)
        ),
        color: isSelected ? AppColors.orangeColor : Colors.transparent
      ),
      child: InkWell(
        onTap: () => setState(() {
          selectedIndex = index;
          if(data.menu[index].title == 'SignOut'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(title: 'TaskRoom')
              ),
            );
          }
        }),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? AppColors.darkBackColor : AppColors.whiteColor,
              ),
            ),
            Text(
              data.menu[index].title,
              style: ralewayStyle.copyWith(
                fontSize:  16,
                color: isSelected ? AppColors.darkBackColor :AppColors.orangeColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal
              ),
            )
          ],
        ),
      ),
    );
  }
}