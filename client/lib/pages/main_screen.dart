import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';





import 'package:flutter/material.dart';



class Board extends StatefulWidget {


  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int? code1;
  String? name;
  int? players;
  final channel = WebSocketChannel.connect(Uri.parse('wss://tic-tac-toe-online-js.glitch.me/ws'));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, dynamic>?;
    if (arguments != null) {
      if (arguments['host'] as bool == true) {
        code1 = arguments['code'] as int;
        name = arguments['name'] as String;
        players = arguments['players'] as int;
        channel.sink.add(jsonEncode({
          'type': 'create_room',
          'room_id': code1.toString(),
          'index': 0,
          'symbol': '',
          'you': '',
          'xTurn': true,
          'name': name,
        }));
      } else {
        code1 = arguments['code'] as int;
        name = arguments['name'] as String;
        players = arguments['players'] as int;
        channel.sink.add(jsonEncode({
          'type': 'join_room',
          'room_id': code1.toString(),
          'index': 0,
          'symbol': '',
          'you': '',
          'xTurn': true,
          'name': name,
        }));
        print(arguments);
      }
    }
  }
    String player = '';
    String currentPlayer = '';
    bool xTurn = true;
    bool winnerFound = false;
    int filledBox = 0;
    List<String> displayXO = ['', '', '', '', '', '', '', '', '',];
  List<String> displayXOTest = ['', '', '', '', '', '', '', '', '',];


    @override
    void initState() {
      super.initState();
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Крестики Нолики'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = jsonDecode(snapshot.data);
                var displayXO = List<String>.from(data['board']);
                var player = data['you'];
                var xTurn = data['xTurn'];
                var type = data['type'];
                var code = data['room_id'];
                var winner = data['winner'] ?? '';
                print(data);
                return type == 'start_game'
                ? Column(
                  children: [

                    SizedBox(height: 32,),
                    Text('You: $player', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    Tooltip(
                      message: xTurn == false && player == 'Player X'
                          ? 'Сейчас ходит соперник'
                          : xTurn == true && player == 'Player O'
                          ? 'Сейчас ходит соперник'
                          : '',
                      textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      child: Container(
                        width: 500,
                        height: 500,
                        child: GridView.builder(
                            itemCount: 9,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              return InkResponse(
                                onTap: () {
                                  if (xTurn == true && player == 'Player X' && displayXO[index] == '') {
                                    setState(() {
                                      displayXO[index] = 'X';
                                      filledBox++;
                                      channel.sink.add(jsonEncode({
                                        'type': type,
                                        'index': index,
                                        'symbol': displayXO[index],
                                        'you': player,
                                        'xTurn': false,
                                        'room_id': code,
                                        'name': name,
                                      }));
                                    });
                                  } else
                                  if (xTurn == false && player == 'Player O' && displayXO[index] == '') {
                                    setState(() {
                                      displayXO[index] = 'O';
                                      filledBox++;
                                      channel.sink.add(jsonEncode({
                                        'type': type,
                                        'index': index,
                                        'symbol': displayXO[index],
                                        'you': player,
                                        'xTurn': true,
                                        'room_id': code,
                                        'name': name,
                                      }));
                                    });
                                  }
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                        width: 5,
                                        color: Colors.white,
                                      ),
                                      color: Colors.amber
                                  ),
                                  child: Center(
                                    child: Text(displayXO[index],
                                      style: TextStyle(fontSize: 48),),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),

                  ],
                )
                : type == 'game_over'
                ? Column(

                  children: [

                    SizedBox(height: 32,),
                    winner != 'Ничья' ? Text('Победил: $winner', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),)
                    : Text('$winner', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: (){
                            channel.sink.add(jsonEncode({
                              'type': 'exit',
                              'name': name,
                              'room_id': code1,
                            }));
                            Navigator.pushNamed(context, '/',);
                          },
                          child: Text('В меню', style: TextStyle(fontSize: 24),)
                      ),
                    ),
                    SizedBox(height: 20,),
                    Tooltip(
                      message: 'Игра окончена',
                      textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      child: Container(
                        width: 500,
                        height: 500,
                        child: GridView.builder(
                            itemCount: 9,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              return InkResponse(
                                onTap: () {

                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                        width: 5,
                                        color: Colors.white,
                                      ),
                                      color: Colors.amber
                                  ),
                                  child: Center(
                                    child: Text(displayXO[index],
                                      style: TextStyle(fontSize: 48),),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),

                  ],
                )
                : type == 'room_not_found'
                ? Column(

                  children: [

                    SizedBox(height: 32,),
                    Text('Комната не найдена', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/',);
                          },
                          child: Text('В меню', style: TextStyle(fontSize: 24),)
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                )
                : type == 'game_already_started'
                ? Column(

                  children: [

                    SizedBox(height: 32,),
                    Text('Игра уже запущена', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/',);
                          },
                          child: Text('В меню', style: TextStyle(fontSize: 24),)
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                )
                : type == 'player_exists'
                ? Column(

                  children: [

                    SizedBox(height: 32,),
                    Text('Игрок с таким именем уже существует!', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/',);
                          },
                          child: Text('В меню', style: TextStyle(fontSize: 24),)
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                )
                : Column(
                  children: [

                    SizedBox(height: 32,),
                    Text('Код: $code', style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w800),),
                    SizedBox(height: 20,),
                    Center(child: CircularProgressIndicator(),)

                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
      );
    }
  }
