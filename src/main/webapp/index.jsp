<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Tic-Tac-Toe</title>
    <style>
        body {
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #333;
            font-size: 36px;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
        }

        .start-btn {
            background-color: #2196F3; /* Blue color */
            color: white;
            padding: 15px 30px;
            font-size: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .start-btn:hover {
            background-color: #1976D2;
        }

        .start-btn:active {
            background-color: #0D47A1;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Tic-Tac-Toe</h1>
        <p>Click below to start a new game.</p>
        <form action="game.jsp">
            <button type="submit" class="start-btn">Start Game</button>
        </form>
    </div>
</body>
</html>


