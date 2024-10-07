import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/TicTacToeServlet")
public class TicTacToeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get the action from the request
        String action = request.getParameter("action");

        if ("play".equals(action)) {
            // Retrieve the game board from the session
            String[][] board = (String[][]) session.getAttribute("board");

            if (board == null) {
                board = new String[3][3]; // Initialize the board if null
                session.setAttribute("board", board);
            }

            // Get the row and column values from the request
            String rowStr = request.getParameter("row");
            String colStr = request.getParameter("col");

            if (rowStr != null && colStr != null) {
                try {
                    int row = Integer.parseInt(rowStr);
                    int col = Integer.parseInt(colStr);

                    // Check if the move is valid (i.e., the cell is empty)
                    if (board[row][col] == null || board[row][col].isEmpty()) {
                        // Get the current player and update the board
                        String currentPlayer = (String) session.getAttribute("currentPlayer");

                        if (currentPlayer == null || "O".equals(currentPlayer)) {
                            board[row][col] = "X"; // Player 1's turn (X)
                            session.setAttribute("currentPlayer", "X"); // Update to Player X
                        } else {
                            board[row][col] = "O"; // Player 2's turn (O)
                            session.setAttribute("currentPlayer", "O"); // Update to Player O
                        }

                        // Check for a winner after each move
                        String winner = checkWinner(board);
                        if (winner != null) {
                            session.setAttribute("winner", winner);
                        }

                        // Switch turns after the move
                        session.setAttribute("currentPlayer", currentPlayer.equals("X") ? "O" : "X");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace(); // Handle any number parsing exceptions
                }
            }
        } else if ("Reset Game".equals(action)) {
            // Reset the session by invalidating it and starting a new session
            session.invalidate(); // This clears the entire session
            session = request.getSession(true); // Start a new session
            resetGame(session); // Initialize the game again with a fresh board
        }

        // Redirect back to the game.jsp page
        response.sendRedirect("game.jsp");
    }

    // Utility method to check for a winner
    private String checkWinner(String[][] board) {
        // Check rows, columns, and diagonals for a winner
        for (int i = 0; i < 3; i++) {
            if (board[i][0] != null && board[i][0].equals(board[i][1]) && board[i][0].equals(board[i][2])) {
                return board[i][0]; // Row win
            }
            if (board[0][i] != null && board[0][i].equals(board[1][i]) && board[0][i].equals(board[2][i])) {
                return board[0][i]; // Column win
            }
        }
        // Check diagonals
        if (board[0][0] != null && board[0][0].equals(board[1][1]) && board[0][0].equals(board[2][2])) {
            return board[0][0]; // Diagonal win
        }
        if (board[0][2] != null && board[0][2].equals(board[1][1]) && board[0][2].equals(board[2][0])) {
            return board[0][2]; // Diagonal win
        }
        return null; // No winner yet
    }

    // Reset game session
    private void resetGame(HttpSession session) {
        // Initialize the board as empty
        String[][] board = new String[3][3];
        session.setAttribute("board", board);
        session.setAttribute("currentPlayer", "X"); // Set Player X to start
        session.setAttribute("winner", null); // Clear winner information
    }
}