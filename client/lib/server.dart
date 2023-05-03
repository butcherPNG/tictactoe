import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Player{
  WebSocket? player;
  Player({required this.player});

}

class Room{
  final List<Player> players;
  final String code;
  List<String> displayXO = ['', '', '', '', '', '', '', '', '',];
  Room({required this.code, required this.players});
  int filledBox = 0;
  void startGame(dynamic message) {
    var player1 = players[0];
    var player2 = players[1];
    var playerX = 'Player X';
    var playerO = 'Player O';

    player1.player!.add(jsonEncode({'type': 'start_game', 'board': displayXO, 'you': playerX, 'xTurn': true, 'room_id': code}));
    player2.player!.add(jsonEncode({'type': 'start_game', 'board': displayXO, 'you': playerO, 'xTurn': true, 'room_id': code}));


  }

  void move(dynamic message){
    var player1 = players[0];
    var player2 = players[1];
    print('Received message: $message');
    var jsonMessage = jsonDecode(message);
    var index = jsonMessage["index"] ?? 0;
    var symbol = jsonMessage["symbol"] ?? '';
    var player = jsonMessage["you"] ?? '';
    var xTurn = jsonMessage["xTurn"] ?? true;
    var roomID = jsonMessage["room_id"];
    print('index: ${index}');
    displayXO[index] = symbol;
    print(displayXO);

    player1.player!.add(jsonEncode({'type': 'start_game', 'status': 'ok', 'board': displayXO, 'you': 'Player X', 'xTurn': xTurn, 'room_id': roomID}));
    player2.player!.add(jsonEncode({'type': 'start_game', 'status': 'ok', 'board': displayXO, 'you': 'Player O', 'xTurn': xTurn, 'room_id': roomID}));
  }

  void checkWinner(List<String> displayXO, var player1, var player2){

    bool winnerFound = false;
    // if (displayXO[0] == displayXO[1] &&
    //     displayXO[0] == displayXO[2] &&
    //     displayXO[0] != '') {
    //   winnerFound = true;
    //   if(displayXO[0] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    // }

    // if (displayXO[3] == displayXO[4] &&
    //     displayXO[3] == displayXO[5] &&
    //     displayXO[3] != '') {
    //   winnerFound = true;
    //   if(displayXO[3] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    // if (displayXO[6] == displayXO[7] &&
    //     displayXO[6] == displayXO[8] &&
    //     displayXO[6] != '') {
    //   winnerFound = true;
    //   if(displayXO[6] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    // if (displayXO[0] == displayXO[4] &&
    //     displayXO[0] == displayXO[8] &&
    //     displayXO[0] != '') {
    //   winnerFound = true;
    //   if(displayXO[0] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    // if (displayXO[2] == displayXO[4] &&
    //     displayXO[2] == displayXO[6] &&
    //     displayXO[2] != '') {
    //   winnerFound = true;
    //   if(displayXO[2] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    // if (displayXO[0] == displayXO[3] &&
    //     displayXO[0] == displayXO[6] &&
    //     displayXO[0] != '') {
    //   winnerFound = true;
    //   if(displayXO[0] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    // if (displayXO[1] == displayXO[4] &&
    //     displayXO[1] == displayXO[7] &&
    //     displayXO[1] != '') {
    //   winnerFound = true;
    //   if(displayXO[1] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    // if (displayXO[2] == displayXO[5] &&
    //     displayXO[2] == displayXO[8] &&
    //     displayXO[2] != '') {
    //   winnerFound = true;
    //   if(displayXO[2] == 'X'){
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player X'}));
    //     print('X wins!');
    //   }else{
    //     player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Player O'}));
    //     print('O wins!');
    //   }
    //
    // }

    if(!winnerFound && filledBox == 9){
      player1.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Ничья'}));
      player2.player!.add(jsonEncode({'type': 'game_over', 'winner': 'Ничья'}));
      print('Nobody wins!');
    }
    filledBox++;
  }
}

void main() async {
  var server = await HttpServer.bind(InternetAddress.anyIPv4, 1120);
  print('Server started on port ${server.port}');

  List<Room> rooms = []; // хранение комнат и соединений клиентов

  await for (var socket in server) {
    // новое соединение
    WebSocket webSocket;
    try {
      webSocket = await WebSocketTransformer.upgrade(socket);
      print('Client connected from ${webSocket}');
    } catch (e) {
      print('Invalid WebSocket request');

      continue;
    }

    webSocket.listen((data) async {
      // обработка сообщений от клиента
      var message = jsonDecode(data);

      void startGame(Room room){

        var player1 = room.players[0];
        var player2 = room.players[1];
        var playerX = 'Player X';
        var playerO = 'Player O';
        List<String> displayXO = ['', '', '', '', '', '', '', '', '',];

        player1.player!.add(jsonEncode({'type': 'start_game', 'board': displayXO, 'you': playerX, 'xTurn': true, 'room_id': room.code}));
        player2.player!.add(jsonEncode({'type': 'start_game', 'board': displayXO, 'you': playerO, 'xTurn': true, 'room_id': room.code}));


      }

      switch (message['type']) {
        case 'start_game':
          print('Is playing');
          print('first message: $message');
          for(var i = 0; i < rooms.length; i++){
            if(rooms[i].code == message['room_id']){
              rooms[i].move(data);
              rooms[i].checkWinner(rooms[i].displayXO, rooms[i].players[0], rooms[i].players[1]);
            }
          }

          break;
        case 'create_room':
        // создание комнаты
          rooms.add(Room(code: message['code'], players: [Player(player: webSocket), Player(player: null)]));

          webSocket.add(jsonEncode({'type': 'room_created', 'room_id': message['code'], 'board': ['', '', '', '', '', '', '', '', '',]}));
          print('Room created: ${message['code']}, Rooms: ${rooms.length}');
          break;
        case 'join_room':
        // подключение к комнате




          var roomId = message['code'];
          for(var i = 0; i < rooms.length; i++){
            if(rooms[i].code == roomId && rooms[i].players[1].player == null){

              rooms[i].players[1].player = webSocket;
              webSocket.add(jsonEncode({'type': 'room_joined', 'room_id': roomId}));
              print('Game started');

              rooms[i].startGame(data);
            }else if (i == rooms.length && rooms[i].code != roomId){
              webSocket.add(jsonEncode({'type': 'room_not_found'}));
            }
          }



          break;
        default:
          print('Unknown message type: ${message['type']}');
          break;
      }

    });

    webSocket.done.then((_) {
      // удаление соединения из комнат
      // for (var room in rooms) {
      //   rooms[3].players.remove();
      //   rooms[room].code.remove();
      //   if (rooms[room].isEmpty) {
      //     rooms.remove(room);
      //   }
      // }
      print('Client disconnected from ${webSocket}');
    });
  }
}