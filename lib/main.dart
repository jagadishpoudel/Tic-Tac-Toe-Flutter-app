import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tic Tac Toe",
      home: TicTacToeScreen(),
    );
  }
}


class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '', growable: false);
  String currentPlayer = 'X';
  String winner = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (winner.isNotEmpty) ? '$winner wins!' : 'Current Player: $currentPlayer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: board.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _markCell(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetBoard,
        tooltip: 'Reset Board',
        child: Icon(Icons.refresh),
      ),

    );
  }

  void _markCell(int index) {
    if (board[index] == '' && winner.isEmpty) {
      setState(() {
        board[index] = currentPlayer;
        if (_checkWin()) {
          winner = currentPlayer;
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWin() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == currentPlayer &&
          board[i * 3 + 1] == currentPlayer &&
          board[i * 3 + 2] == currentPlayer) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] == currentPlayer &&
          board[i + 3] == currentPlayer &&
          board[i + 6] == currentPlayer) {
        return true;
      }
    }

    // Check diagonals
    if (board[0] == currentPlayer && board[4] == currentPlayer && board[8] == currentPlayer) {
      return true;
    }
    if (board[2] == currentPlayer && board[4] == currentPlayer && board[6] == currentPlayer) {
      return true;
    }

    return false;
  }

  void _resetBoard() {
    setState(() {
      board = List.filled(9, '', growable: false);
      currentPlayer = 'X';
      winner = '';
    });
  }
}
