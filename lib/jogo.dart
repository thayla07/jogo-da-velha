import 'package:flutter/material.dart';

class JogoDaVelhaPage extends StatefulWidget {
  const JogoDaVelhaPage({super.key});

  @override
  _JogoDaVelhaPageState createState() => _JogoDaVelhaPageState();
}

class _JogoDaVelhaPageState extends State<JogoDaVelhaPage> {
  List<String> board = List.generate(9, (index) => ''); // Initialize the game board with empty strings
  bool isXTurn = true; // Track whose turn it is (X or O)

  void _makeMove(int index) {
    if (board[index] == '') { // If the cell is empty, make a move
      setState(() {
        board[index] = isXTurn ? 'X' : 'O'; // Assign X or O based on the turn
        isXTurn = !isXTurn; // Switch turn
      });

      if (_checkWinner()) {
        _showWinnerDialog(); // Show winner dialog if there is a winner
      }
    }
  }

  bool _checkWinner() {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' && // Check if the cells in a pattern are the same
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  void _showWinnerDialog() {
    String winner = isXTurn ? 'O' : 'X'; // Determine the winner
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Jogador $winner venceu!'), // Display winner
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                board = List.generate(9, (index) => ''); // Reset the board
              });
              Navigator.of(context).pop();
            },
            child: const Text('Jogar Novamente'), // Restart the game
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo da Velha')), // App bar with title
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isXTurn ? 'Vez do Jogador X' : 'Vez do Jogador O',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(  // Use Expanded to ensure GridView takes remaining space
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,  // 3 columns
                  crossAxisSpacing: 8,  // Space between cells
                  mainAxisSpacing: 8,   // Space between cells
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _makeMove(index), // Detect tap to make a move
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: board[index] == 'X' ? Colors.blue : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
