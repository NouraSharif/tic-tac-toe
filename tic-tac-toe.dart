import 'dart:io';

void main() {
  // Initialize the game board with numbers 1-9
  List<String> board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  print("Welcome to Tic-Tac-Toe!\n");
  printBoard(board);

  print("Player 1 = X");
  print("Player 2 = O\n");

  // Loop for a maximum of 9 turns (full board)
  for (int turn = 0; turn < 9; turn++) {
    // Determine which player's turn it is
    String player = (turn % 2 == 0) ? 'X' : 'O';
    String playerName = (player == 'X') ? 'Player 1' : 'Player 2';

    // Ask the player for their move
    stdout.write(
        "$playerName, where do you want to place $player? (Choose a number from 1 to 9): ");
    String? input = stdin.readLineSync();
    int? move = int.tryParse(input ?? '');

    // Validate the move (must be a number from 1 to 9)
    if (move == null || move < 1 || move > 9) {
      print("⚠️ Invalid input! Please enter a number between 1 and 9.");
      turn--; // Don't count this invalid turn
      continue;
    }

    // Check if the selected cell is already taken
    if (board[move - 1] == 'X' || board[move - 1] == 'O') {
      print("⚠️ That cell is already taken! Try another one.");
      turn--; // Don't count this invalid turn
      continue;
    }

    // Place the player's symbol in the selected cell
    board[move - 1] = player;
    printBoard(board);

    // Check if the player has won
    if (checkWinner(board, player)) {
      print("🎉 $playerName wins!");
      return;
    }
  }

  // If no one won after 9 turns, it's a draw
  print("🤝 It's a draw! No winner.");
}

// Function to print the current state of the board
void printBoard(List<String> board) {
  print("\n${board[0]} | ${board[1]} | ${board[2]}");
  print("--+---+--");
  print("${board[3]} | ${board[4]} | ${board[5]}");
  print("--+---+--");
  print("${board[6]} | ${board[7]} | ${board[8]}\n");
}

// Function to check if a player has won
bool checkWinner(List<String> board, String player) {
  // List of all winning combinations (rows, columns, diagonals)
  List<List<int>> wins = [
    [0, 1, 2], // Top row
    [3, 4, 5], // Middle row
    [6, 7, 8], // Bottom row
    [0, 3, 6], // Left column
    [1, 4, 7], // Middle column
    [2, 5, 8], // Right column
    [0, 4, 8], // Diagonal from top-left
    [2, 4, 6], // Diagonal from top-right
  ];

  // Loop through each winning combination and check if all positions match the player's symbol
  for (var pos in wins) {
    if (board[pos[0]] == player &&
        board[pos[1]] == player &&
        board[pos[2]] == player) {
      return true; // Player has won
    }
  }

  return false; // No winner
}
