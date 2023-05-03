import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/config.dart';
import 'package:tictactoe/pages/main_screen.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крестики Нолики',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        '/': (context) => Lobby(),
        '/room': (context) => Board()
      },
    );
  }
}

@RoutePage()
class Lobby extends StatefulWidget {


  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  var playerId;
  @override
  void initState() {
    var random = Random();
    playerId = random.nextInt(9000) + 1000;
    nameController = TextEditingController(text: 'Player$playerId');
    super.initState();
  }
  late TextEditingController nameController;
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Крестики Нолики'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            children: [
              SizedBox(height: 32,),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Имя',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      var random = Random();
                      var code = random.nextInt(9000) + 1000;
                      Navigator.pushNamed(
                        context,
                        '/room',
                        arguments: {'code': code, 'host': true, 'name': nameController.text, 'players': 1},
                      );
                    },
                    child: Text('Создать комнату', style: TextStyle(fontSize: 24),)
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Введите код'),
                              content: TextField(
                                controller: codeController,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Код'
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.pushNamed(
                                        context,
                                        '/room',
                                        arguments: {
                                            'code':
                                                int.parse(codeController.text),
                                            'host': false,
                                            'name': nameController.text,
                                            'players': 2
                                          },
                                        );
                                    },
                                    child: Text('Войти')
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Text('Войти в комнату', style: TextStyle(fontSize: 24),)
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}





