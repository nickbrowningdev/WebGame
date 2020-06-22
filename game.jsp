<%@page import="game.GameBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="game.Briefcase"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

	Briefcase[] briefcaseList = gameBean.getBriefcaseList();
	int roundNb = gameBean.getRoundNb();
	int casesToOpen = gameBean.getCasesToOpen();

	String buttonType = (casesToOpen > 0) ? "submit" : "button";

	String pageTitle = "Round " + Integer.toString(roundNb);
	String submitButtonText = "Continue";
	String submitButtonColor = "btn-primary";

    if (roundNb == 5) 
    {
		pageTitle += " - Last Round";

        if (casesToOpen == 0) 
        {
			session.setAttribute("casesMessage", "Click on the Finish button to see cash prize.");

			submitButtonText = "Finish";
			submitButtonColor = "btn-success";
		}
	}
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
				<h2><%=pageTitle%></h2>
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
				<h3>Instructions</h3>
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
                        Press continue to progress to the bank. <br>
                    </p>
                </div>
				<%
					if (session.getAttribute("casesMessage") != null) {
				%>
				<p class="important-text">
					<strong><%=session.getAttribute("casesMessage")%></strong>
				</p>
				<%
					session.removeAttribute("casesMessage");

					} else {
				%>
				<p class="important-text">
					<strong>Briefcases left to open : <%=casesToOpen%></strong>
				</p>
				<%
					}
					if (session.getAttribute("gameSuccess") != null) {
				%>
				<p class="important-text success"><%=(String) session.getAttribute("gameSuccess")%></p>
				<%
					session.removeAttribute("gameSuccess");
					}
				%>
			</div>
			<div class="col-sm-6">
				<form action="/c3302779_assignment2/game.Game" method="post">
					<div class="form-group">
						<table>
							<tr>
								<%
									int i = 0;
									for (Briefcase briefcase : briefcaseList) {
										i++;
										if (briefcase.isRevealed()) {
								%>
								<td class="col-sm-3"><p class="amount">
										$
										<%
											if (briefcase.getAmount() != 0.5) {
														out.println(Math.round(briefcase.getAmount() * 100) / 100);
													} else {
														out.println(briefcase.getAmount());
													}
										%>
									</p></td>
								<%
									} else {
								%>
								<td class="col-sm-3"><input type="<%=buttonType%>"
									name="briefcaseSelect" value="<%=briefcase.getNumber()%>"
									id="<%=briefcase.getNumber()%>"><label
									for="<%=briefcase.getNumber()%>"></label></td>
								<%
									}
										if ((i % 4 == 0) && (i < briefcaseList.length)) {
								%>
							</tr>
							<tr>
								<%
									}
									}
								%>
							</tr>
						</table>
					</div>

					<div class="row">
						<div class="col-sm-5 col-sm-offset-1">
							<button class="btn btn-default btn-block" type="submit"
								name="game_selection" value="save_game">
								<i class="fa fa-floppy-o"></i> Save game
							</button>
						</div>
						<div class="col-sm-5">
							<button class="btn <%=submitButtonColor%> btn-block"
								type="submit" name="next_round" value="">
								<i class="fa fa-forward"></i>
								<%=submitButtonText%>
							</button>
						</div>
					</div>
				</form>
				<%
					if (session.getAttribute("gameError") != null) {
				%>
				<p class="important-text error"><%=(String) session.getAttribute("gameError")%></p>
				<%
					session.removeAttribute("gameError");
					}
				%>

			</div>
		</div>
	</div>

	<footer>
        <p>
            &copy; 2019, All Rights Are Reserved To Browning, Mather, Percy
        </p>
    </footer>
</body>
</html>