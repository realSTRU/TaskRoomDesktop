import 'dart:async';
import 'dart:convert';

import 'package:desk/app_colors.dart';
import 'package:desk/app_icons.dart';
import 'package:desk/app_styles.dart';
import 'package:desk/dashboard_screen.dart';
import 'package:desk/dto/Credential.dart';
import 'package:desk/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

import 'dto/Task.dart';
import 'dto/User.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  final String title;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool sesion = false;
  User user = User();

  Future<bool> login(Credential credential) async {
    final String url = 'http://gdp-web-api.somee.com/api/Auth/login';
    bool loggedin = false;


    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(credential.toJson()),
      );
        print(json.encode(credential.toJson()));
      if (response.statusCode == 200) {
        print(response.body);
        loggedin = true;
        Map<String, dynamic> responseData = json.decode(response.body);
        user = User.fromJson(responseData); // Aquí construyes el objeto User
        print(user.name);
        print(response.body);
        // Verifica si la clave 'success' existe y su valor no es nulo
        if (true) {
          if (true) {
            print('Inicio de sesión exitoso');
            // Aquí puedes manejar la navegación a la siguiente pantalla u otros procesos después del inicio de sesión exitoso
          } else {
            // Verifica si la clave 'message' existe y su valor no es nulo
            String message = responseData.containsKey('message')
                ? responseData['message']
                : 'Mensaje no disponible';
            print('Inicio de sesión fallido: $message');
          }
        } else {
          print(
              'Respuesta no válida: success no está presente o su valor es nulo');
        }
      } else {
        loggedin = false;
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción: $e');
    }
    return loggedin;
  }
    bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backBoneColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        Expanded(
        child: Container(
        color: AppColors.orangeColor,
          child: Center(
            child: Gif(
              fps: 30,
              autostart: Autostart.once,
              image: const AssetImage('assets/images/taskroommovement.gif'), // Ruta relativa del archivo GIF
              fit: BoxFit.cover,
              height: double.infinity,// Ajusta la imagen para cubrir completamente el contenedor
            ),
          ),
        ),
      ),
            Expanded(
              child:Container(
                height: height,
                margin: EdgeInsets.symmetric(horizontal: height * 0.12),
                color: AppColors.backBoneColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.145),
                    RichText(text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Let’s',
                          style: ralewayStyle.copyWith(
                            fontSize: 25.0,
                            color : AppColors.darkBackColor,
                            fontWeight: FontWeight.normal
                          )
                        ),
                        TextSpan(
                          text: ' Sign In 👇',
                          style : ralewayStyle.copyWith(
                            fontWeight: FontWeight.w800,
                            color : AppColors.darkBackColor,
                            fontSize: 25.0
                          )

                        )
                      ]
                    )),
                    SizedBox(height: height * 0.02),
                    Text('Hey, Enter your details to get sign in \nto your account.',
                    style: ralewayStyle.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color : AppColors.textColor
                    )),
                    SizedBox(height: height * 0.064),

                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Text('Username',
                      style : ralewayStyle.copyWith(
                        fontSize: 12.0,
                        color : AppColors.darkBackColor,
                        fontWeight: FontWeight.w700
                      )),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      height: 50.0,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color : AppColors.whiteColor
                      ),
                      child: TextFormField(
                        controller: userNameController,
                        style:ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkBackColor,
                            fontSize: 12.0
                        ) ,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            onPressed: (){},
                            icon : Image.asset(AppIcons.emailIcon),
                          ),
                          contentPadding: const EdgeInsets.only(top: 16.0) ,
                          hintText: 'Enter your username',
                          hintStyle: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkBackColor.withOpacity(0.5),
                            fontSize: 12.0
                          )
                        ),
                      ),
                    ),

                    SizedBox(height: height*0.014),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Text('Password',
                          style : ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color : AppColors.darkBackColor,
                              fontWeight: FontWeight.w700
                          )),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      height: 50.0,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color : AppColors.whiteColor
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        style:ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkBackColor,
                            fontSize: 12.0
                        ) ,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Image.asset(AppIcons.eyeIcon),
                            ),
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon : Image.asset(AppIcons.lockIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0) ,
                            hintText: 'Enter your password',
                            hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkBackColor.withOpacity(0.5),
                                fontSize: 12.0
                            )
                        ),
                      ),
                    ),


                    SizedBox(height: height*0.03),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed:(){},
                          child: Text('Forgot your password?',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.greenTaskColor,
                            fontWeight: FontWeight.w600
                          ),)),
                    ),
                    SizedBox(height: height*0.05),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          String username = userNameController.text;
                          String password = passwordController.text;
                          Credential credential = Credential(username, password);
                          print('le di al boton');
                          print(username + password);
                          sesion = await login(credential);
                          if(sesion){
                            toastification.show(
                              context: context,
                              title: Text('Inicio de sesion realizado con exito!'),
                              type: ToastificationType.success,
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(user: user),
                              ),
                            );
                          }
                          else
                          {
                            toastification.show(
                              context: context,
                              title: Text('Inicio de sesion Fallido'),
                              type: ToastificationType.error,
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                            print('no');
                          }

                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0,vertical: 18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColors.orangeColor
                          ),
                          child: Text('Log In',
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0
                          ),),
                        ),
                      ),
                    )

                  ],
                ),
              )
              ,
            ),
          ],
        ) ,
      ),
    );
  }
}
