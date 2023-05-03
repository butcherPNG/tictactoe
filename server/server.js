const WebSocket = require('ws');

class Player {
    constructor(player) {
      this.player = player;
    }
}

class Room {
    constructor(code, players) {
      this.players = players;
      this.code = code;
      this.displayXO = ['', '', '', '', '', '', '', '', '', ''];
      this.filledBox = 0;
    }

    start_game() {
        let player1 = this.players[0];
        let player2 = this.players[1];
        player1.player.send(JSON.stringify({
            type: 'start_game',
            board: this.displayXO,
            you: 'Player X',
            xTurn: true,
            room_id: this.code
          }));

        player2.player.send(JSON.stringify({
            type: 'start_game',
            board: this.displayXO,
            you: 'Player O',
            xTurn: true,
            room_id: this.code
          }));  
    }

    update_board(message){
        this.displayXO[message['index']] = message['symbol'];
        console.log(this.displayXO);
    }

    send_new_data(message){
        let player1 = this.players[0];
        let player2 = this.players[1];
        player1.player.send(JSON.stringify({
            type: 'start_game',
            board: this.displayXO,
            you: 'Player X',
            xTurn: message['xTurn'],
            room_id: this.code
          }));

        player2.player.send(JSON.stringify({
            type: 'start_game',
            board: this.displayXO,
            you: 'Player O',
            xTurn: message['xTurn'],
            room_id: this.code
          }));
    }

    check_winner(){
        let player1 = this.players[0];
        let player2 = this.players[1];
        let winnerFound = false;
        this.filledBox++;
        if(this.displayXO[0] == this.displayXO[1] && this.displayXO[0] == this.displayXO[2] && this.displayXO[0] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[0] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[3] == this.displayXO[4] && this.displayXO[3] == this.displayXO[5] && this.displayXO[3] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[3] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[6] == this.displayXO[7] && this.displayXO[6] == this.displayXO[8] && this.displayXO[6] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[6] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[0] == this.displayXO[4] && this.displayXO[0] == this.displayXO[8] && this.displayXO[0] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[0] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[2] == this.displayXO[4] && this.displayXO[2] == this.displayXO[6] && this.displayXO[2] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[2] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[0] == this.displayXO[3] && this.displayXO[0] == this.displayXO[6] && this.displayXO[0] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[0] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[1] == this.displayXO[4] && this.displayXO[1] == this.displayXO[7] && this.displayXO[1] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[1] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[2] == this.displayXO[5] && this.displayXO[2] == this.displayXO[8] && this.displayXO[2] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[2] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(this.displayXO[0] == this.displayXO[1] && this.displayXO[0] == this.displayXO[2] && this.displayXO[0] != ''){
            winnerFound = true;
            console.log('Winner found');
            if(this.displayXO[0] === 'X'){
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player X', board: this.displayXO}));
            }else{
                player1.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
                player2.player.send(JSON.stringify({type: 'game_over', winner: 'Player O', board: this.displayXO}));
            }
        }

        if(winnerFound === false && this.filledBox === 9){
            winnerFound = true;
            player1.player.send(JSON.stringify({type: 'game_over', winner: 'Ничья', board: this.displayXO}));
            player2.player.send(JSON.stringify({type: 'game_over', winner: 'Ничья', board: this.displayXO}));
        }
        return winnerFound;
    }
}    

const rooms = [];

const server = new WebSocket.Server({ port: 1120 });

server.on('listening', () => {
    console.log(`Server started on port ${server.options.port}`);
});

server.on('connection', (webSocket) => {
    console.log(`Client connected from ${webSocket}`);

    webSocket.on('message', (data) => {
        
        const message = JSON.parse(data);

        console.log(`Message: ${JSON.stringify(message)}`);

        switch (message['type']){
            case 'start_game':
                    console.log('game start');
                    for(let i = 0; i < rooms.length; i++){
                        if(rooms[i].code === message['room_id']){
                            rooms[i].update_board(message);
                            let game_over = rooms[i].check_winner();
                            console.log(`Game over: ${game_over}`);
                            if(game_over === true){
                                console.log(`Game over`);
                            }else{
                                rooms[i].send_new_data(message);
                            }
                            
                        }
                    }
                break;

            case 'create_room':
                    console.log('create room');
                    rooms.push(new Room(message['room_id'], [new Player(webSocket), new Player(null)]));
                    webSocket.send(JSON.stringify({type: 'room_created', room_id: message.room_id, board: ['', '', '', '', '', '', '', '', '', '']}));
                break;

            case 'join_room':
                    console.log('join room');
                    for(let i = 0; i < rooms.length; i++){
                        if(rooms[i].code === message['room_id'] && rooms[i].players[1].player === null){
                            rooms[i].players[1].player = webSocket;
                            webSocket.send(JSON.stringify({type: 'room_joined', room_id: rooms[i].code}));
                            rooms[i].start_game();
                        }else if(rooms[i].code === message['room_id'] && rooms[i].players[1].player != null){
                            webSocket.send(JSON.stringify({type: 'game_already_started', board: ['', '', '', '', '', '', '', '', '', '']}));
                        }else{
                            webSocket.send(JSON.stringify({type: 'room_not_found', board: ['', '', '', '', '', '', '', '', '', '']}));
                        }
                    }
                break;  
            
            case 'exit':
                    console.log(rooms.length);
                    for(let i = 0; i < rooms.length; i++){
                        if(rooms[i].code === message['room_id']){
                            console.log('Room deleted');
                            rooms.splice(i, 1);
                            console.log(rooms.length);
                        }
                    }

                break;
        }
    });
});