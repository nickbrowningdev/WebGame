<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String username, value = "";

    if ((username = (String) session.getAttribute("username")) != null) 
    {
		value = "value='" + username + "'";
		session.removeAttribute("username");
	}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page | Deal or No Deal</title>
        <meta name="description" content="Deal or No Deal">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/bootstrap.css">

        <script src="js/jquery-2.2.4.js" type="text/javascript"></script>
        <script src="js/jquery.validate.js" type="text/javascript"></script>
        <script src="js/home.js" type="text/javascript"></script>
        <script src="js/script.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
    </head>

    <body>
        <div class="container">
            <div class="header-container">
                <header>
                    <h1>Deal or No Deal</h1>
                    <h2>Home Page</h2>
                </header>
            </div>

            <div class="instruction-container">
                <p class = "instructions-information">
                    Deal Or No Deal revolves around the opening of set of numbered briefcases, each containing a cashing prize. <br>   
                    There are 12 briefcases which are numbered 1 through 12. <br>                                            
                    Each briefcase contains a unique monetary amount from the following figures: $0.5, $1, $10, $100, $200, $500, $1000, $2000, $5000, $10000, $20000, $50000. <br>    
                    The contents of all of the cases are known at the start of the game, but the specific location of any prize is unknown. <br>                    
                    The contestant claims a case to begin the game. The case's value is not revealed until the conclusion of the game. <br>    
                    After selecting a certain amount of briefcases. A offer is provided and the player is given the option to either 'Deal' or 'No Deal'. <br>    
                    When a user selects 'Deal', the offer is accepted and quits the game. <br>    
                    When a user selects 'No Deal', the offer is refused and moves to the next round. <br>
                </p>
            </div>

            <div class="gameselection-form-container">
                <form action="/c3302779_assignment2/game.Game" method="post" name="homeForm" onSubmit="return checkHome(homeForm);">
                    <input type="text" name="username" placeholder="Username" <%=value%>>

                    <button type="submit" name="game_selection" value="new_game">
                        New Game
                    </button>

                    <button type="submit" name="game_selection" value="load_game">
                        Load Game
                    </button>
                </form>
            </div>
        </div>
    </body>
</html>