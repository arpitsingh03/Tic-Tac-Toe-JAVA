<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tic-Tac-Toe Game</title>
    <style>
        body {
            background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%);
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100vh;
            margin: 0;
            position: relative;
        }

        h1 {
            color: #333;
            font-size: 36px;
            margin-bottom: 20px;
        }

        .board {
            display: grid;
            grid-template-columns: repeat(3, 100px);
            grid-gap: 10px;
            margin-bottom: 30px;
        }

        .cell {
            width: 100px;
            height: 100px;
            background-color: white;
            border: 2px solid #333;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 36px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .cell:hover {
            background-color: #e0e0e0;
        }

        .cell:disabled {
            background-color: #f9f9f9;
            color: #aaa;
            cursor: not-allowed;
        }

        .winner {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        .reset-btn {
            background-color: #f44336;
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .reset-btn:hover {
            background-color: #e53935;
        }

        .reset-btn:active {
            background-color: #d32f2f;
        }

        /* Style for current player - moved to top-right */
        .current-player {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 18px;
            color: #fff;
            background-color: rgba(0, 0, 0, 0.6);
            padding: 10px;
            border-radius: 5px;
        }
    </style>
    <script>
        function handleCellClick(row, col) {
            document.getElementById("row").value = row;
            document.getElementById("col").value = col;
            document.getElementById("action").value = "play";
            document.getElementById("gameForm").submit();
        }

        function resetGame() {
            document.getElementById("action").value = "Reset Game";
            document.getElementById("gameForm").submit();
        }
    </script>
</head>
<body>
    <h1>Tic-Tac-Toe</h1>
    <form id="gameForm" action="TicTacToeServlet" method="post">
        <input type="hidden" id="action" name="action" value="play" />
        <input type="hidden" id="row" name="row" value="" />
        <input type="hidden" id="col" name="col" value="" />
        <div class="board">
            <%
                // Initialize board and session variables if they are not set
                String[][] board = (String[][]) session.getAttribute("board");
                String currentPlayer = (String) session.getAttribute("currentPlayer");
                String winner = (String) session.getAttribute("winner");

                if (board == null) {
                    board = new String[3][3]; // Initialize an empty 3x3 board
                    session.setAttribute("board", board);
                    currentPlayer = "X"; // Start the game with player X
                    session.setAttribute("currentPlayer", currentPlayer);
                }

                // Render the game board
                for (int i = 0; i < 3; i++) {
                    for (int j = 0; j < 3; j++) {
                        String cellValue = board[i][j] != null ? board[i][j] : "";
                        out.println("<button type='button' onclick='handleCellClick(" + i + ", " + j + ")' class='cell'>" + cellValue + "</button>");
                    }
                }

                // Display winner message or current player
                if (winner != null) {
                    out.println("<div class='winner'>Player " + winner + " wins!</div>");
                }
            %>
        </div>
        <div class="current-player">
            <% if (currentPlayer != null && winner == null) { %>
                Current Player: <%= currentPlayer %>
            <% } %>
        </div>
        <button type="button" class="reset-btn" onclick="resetGame()">Reset Game</button>
    </form>
</body>
</html>