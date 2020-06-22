<%@page import="game.GameBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	GameBean gameBean = (GameBean) session.getAttribute("gameBean");

    if ((session.getAttribute("gameBean") == null) || (!gameBean.isGameEnded())) 
    {
		response.sendRedirect(request.getContextPath());
		return;
	}

	double cashPrize = gameBean.getCashPrize();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Game Ended | Deal or No Deal</title>
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
		<header>
		<div class="row">
			<div class="col-sm-9">
				<h1>Deal or No Deal</h1>
				<h2>End Game</h2>
			</div>
			<div class="col-sm-3">
				<a href="<%=request.getContextPath()%>"
					class="btn btn-default btn-lg pull-right" style="margin-top: 30px">Home
					Page</a>
			</div>
		</div>
		</header>

		<div class="row">
			<div class="col-sm-6">
				<h3>Information</h3>
				<p>The game is finished.</p>
				<p>
					Click 'Home Page' to start a new game.
				</p>
			</div>
			<div class="col-sm-6">
				<p class="cash-prize">
					$
					<%=cashPrize%></p>
			</div>
		</div>

	</div>

	<footer>
	<p>
		&copy; Nicholas Browning, 2019
	</p>
	</footer>
</body>
</html>