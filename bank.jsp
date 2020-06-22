<%@page import="game.GameBean"%>
<%@page import="game.Bank"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	GameBean gameBean = (GameBean) request.getSession().getAttribute("gameBean");

    if (session.getAttribute("gameBean") == null) 
    {
		response.sendRedirect(request.getContextPath());
		return;
    } 
    else if (gameBean.isGameEnded()) 
    {
		response.sendRedirect("/c3302779_assignment2/end.jsp");
		return;
    } 
    else if (gameBean.getCasesToOpen() > 0) 
    {
		response.sendRedirect("/c3302779_assignment2/game.jsp");
		return;
	}

	int roundNb = gameBean.getRoundNb();

	double bankOffer = (double) session.getAttribute("bankOffer");
	double maxAmount = (double) session.getAttribute("maxAmount");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Round <%=roundNb%> | Deal or No Deal
</title>
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
				<h2>
					Round
					<%=roundNb%>
					- Bank Offer
				</h2>
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
				<h3>Make your choice</h3>
				<h4>
					Bank offer<span class="pull-right">$ <%=bankOffer%>
					</span>
				</h4>

				<h4>
					Largest amount unrevealed<span class="pull-right">$ <%=Math.round(maxAmount * 100) / 100%>
					</span>
				</h4>

				<form action="/c3302779_assignment2/game.Game" method="post">
					<div class="row">
						<div class="col-sm-6">
							<button class="btn btn-default btn-block" type="submit"
								name="deal_selection" value="deal">
								<i class="fa fa-suitcase"></i> Deal
							</button>
						</div>
						<div class="col-sm-6">
							<button class="btn btn-primary btn-block" type="submit"
								name="deal_selection" value="no_deal">
								<i class="fa fa-forward"></i> No Deal
							</button>
						</div>
					</div>
				</form>
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