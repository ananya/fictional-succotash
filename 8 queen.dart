import 'dart:io'; // Libraies for the program

List<List<String>> board =
    List(); // Creates a chess board as an empty array because the board length user defined
int queen_amount; // The variable taken as input. controls the length of board and no. of queens

bool make_board(v, x) {
  // Function to create board. Recursive.
  if (x == 0) {
    return true;
  }
  List<String> y = List();
  for (int i = 0; i < v; i++) {
    y.add("*");
  }
  board.add(y);
  make_board(v, x - 1);
}

void printB(int f) {
  // Prints the board with current placement of queens
  for (var i in board) {
    print(i);
  }
  print(f);
  print("\n");
}

bool check_queen(int y, int x) {
  // Checks if a particular block is safe for a queen
  for (int i = 0; i <= y; i++) {
    // Vertical
    if (board[i][x] == "O") {
      return false;
    }
    if (x >= i) {
      // Upper left diagonal
      if (board[y - i][x - i] == "O") {
        return false;
      }
    }
    if (x + i < board.length) {
      // Upper right diagoonal
      if (board[y - i][x + i] == "O") {
        return false;
      }
    }
  }
  return true;
}

int found = 0; // No. of solutions found

int recurse(int n, int y) {
  // Recursive function to go through every block and place queens correctly.
  if (n == 0) {
    // Terminating condition
    found += 1;
    printB(found);
    return 0;
  }
  for (int i = 0; i < board.length; i++) {
    if (check_queen(y, i)) {
      // If the block is safe
      board[y][i] = "O"; // Place a queen there
      recurse(n - 1, y + 1); // Do recursion in the next row and check back
      board[y][i] =
          "*"; // Remove the older queen and go ahead for more solutions.
    }
  }
}

int main() {
  print("How many queens: ");
  queen_amount = int.parse(stdin.readLineSync()); // Input for queens
  make_board(queen_amount, queen_amount); // Make a board based on input queens.
  recurse(board.length, 0); // Start finding solutions
  return 0;
}
