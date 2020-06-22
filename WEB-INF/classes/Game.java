
// request and response for game and bank jsps

package game;

import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Map.Entry;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/game.Game"})
public class Game extends HttpServlet implements Serializable
{
    private static final long serialVersionUID = 1L;

    public Game() 
	{
		super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher;

        if(session.getAttribute("gameBean") != null) 
        {
			session.removeAttribute("gameBean");
		}

		dispatcher = getServletContext().getRequestDispatcher("/c3302779_assignment2/home.jsp");
		dispatcher.forward(request, response);
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher;

		GameBean gameBean = null;
		String username = null;
		String game_selection = null;
		String deal_selection = null;
		String next_round = null;
		int briefcaseNb = -1;

        for(Entry<String, String[]> entry : request.getParameterMap().entrySet()) 
        {
			String paramName = entry.getKey();
			String[] paramValues = entry.getValue();

            switch (paramName) 
            {
			    case "username":
				    username = paramValues[0];
				    break;

			    case "game_selection":
				    game_selection = paramValues[0];
				    break;

			    case "briefcaseSelect":
				    briefcaseNb = Integer.parseInt((String) paramValues[0]);
				    break;

			    case "next_round":
				    next_round = paramName;
				    break;

			    case "deal_selection":
				    deal_selection = paramValues[0];
				    break;
			}
		}

		// Request from 'home.jsp'
        if(username != null && game_selection != null) 
        {			
            switch(game_selection) 
            {
                // if a new game is created successfully
			    case "new_game":
				    gameBean = new GameBean();
				    gameBean.setUsername(username);

				    // overwrites save file 
                    if(loadGame(request, username) != null) 
                    {
					    saveGame(request, username, gameBean);
				    }

				    session.setAttribute("gameSuccess", "Game created successfully.");
				    session.setAttribute("gameBean", gameBean);
				    response.sendRedirect("/c3302779_assignment2/game.jsp");
				    break;
                
                // If the game was loaded successfully
			    case "load_game":				    
                    if((gameBean = loadGame(request, username)) != null) 
                    {
					    session.setAttribute("gameSuccess", "Game loaded successfully.");
					    session.setAttribute("gameBean", gameBean);

                        // if game file was saved at gameover screen
                        if(gameBean.isGameEnded()) 
                        {
						    response.sendRedirect("/c3302779_assignment2/end.jsp");
                        } 
                        else 
                        {
						    response.sendRedirect("/c3302779_assignment2/game.jsp");
					    }
                    } 
                    else 
                    {
					    session.setAttribute("gameError", "Username doesn't have a save slot.");
					    session.setAttribute("username", username);
					    response.sendRedirect(request.getContextPath());
				    }
				    break;

			}
        } 
        else 
        { 
            // The request comes from game.jsp or bank.jsp
			gameBean = (GameBean) session.getAttribute("gameBean");

            if(gameBean != null) 
            {
				Briefcase[] briefcaseList = gameBean.getBriefcaseList();
				int casesToOpen = gameBean.getCasesToOpen();
				int roundNb = gameBean.getRoundNb();
				username = gameBean.getUsername();
				double cashPrize;

				// If the user tries to save the current game
                if(game_selection != null && game_selection.equals("save_game")) 
                {
					saveGame(request, username, gameBean);

					session.setAttribute("gameSuccess", "Game saved successfully.");
					response.sendRedirect(request.getContextPath());
				}

				// If the user clicks on a briefcase
                if (briefcaseNb != -1) 
                {
                    for(Briefcase briefcase : briefcaseList) 
                    {
                        if(casesToOpen > 0) 
                        {
							//Check if briefcase is not revealed... yet
                            if((briefcase.getNumber() == briefcaseNb) && (briefcase.isRevealed() == false)) 
                            {
								briefcase.setRevealed(true);
								casesToOpen--;
								gameBean.setCasesToOpen(casesToOpen);
							}
                        } 
                        else 
                        {
							session.setAttribute("casesMessage", "No more cases can be opened.");
						}
					}

					session.setAttribute("token", true);
					response.sendRedirect("/c3302779_assignment2/game.jsp");
				}

                if (next_round != null) 
                {

					// If the user clicked on the 'Continue' button   
                    if(roundNb < 5) 
                    {
						// If the user has no more cases to open, redirected to Bank servlet
                        if(casesToOpen == 0) 
                        {
							dispatcher = getServletContext().getRequestDispatcher("/game.Bank");
							dispatcher.forward(request, response);
                        } 
                        else 
                        {
							session.setAttribute("gameError", "You must reveal " + casesToOpen + " more briefcases.");
							response.sendRedirect("/c3302779_assignment2/game.jsp");
						}
                    } 
                    else 
                    {   
                        for(Briefcase briefcase : briefcaseList) 
                        {
							// searching briefcase
                            if(!briefcase.isRevealed()) 
                            {
								// last briefcase to be revealed is the total cash prize.
								cashPrize = briefcase.getAmount();
								gameBean.setCashPrize(cashPrize);
							}
						}

						// The game is finished
						gameBean.setGameEnded(true);
						saveGame(request, username, gameBean);
						response.sendRedirect("/c3302779_assignment2/end.jsp");
					}
				}

				// If the user clicks on 'Deal' or 'No Deal' button
                if (deal_selection != null) 
                {
                    if(deal_selection.equals("deal")) 
                    {
						cashPrize = (double) session.getAttribute("bankOffer");
						gameBean.setCashPrize(cashPrize);
						gameBean.setGameEnded(true);

						saveGame(request, username, gameBean);
						session.setAttribute("gameSuccess", "Game saved successfully.");

						response.sendRedirect("/c3302779_assignment2/end.jsp");

                    } 
                    else if (deal_selection.endsWith("no_deal")) 
                    {
						roundNb++;
						gameBean.setRoundNb(roundNb);

						response.sendRedirect("/c3302779_assignment2/game.jsp");
					}
				}
            } 
            else 
            {
				session.setAttribute("gameError", "An error occured, please try again.");
				response.sendRedirect(request.getContextPath());
			}
		}

	}

    // loads .ser file extension
	private GameBean loadGame(HttpServletRequest request, String username) {
		username = username.toLowerCase();
		InputStream inputStream = getServletContext().getResourceAsStream("/WEB-INF/savedgames/" + username + ".ser");

        if(inputStream != null) 
        {
            try 
            {
				// We read the saved object
				ObjectInputStream objectInputStream = new ObjectInputStream(inputStream);
				GameBean savedGame = (GameBean) objectInputStream.readObject();
				
				objectInputStream.close();
				inputStream.close();

				// If the saved game was not ended, we clear the data from the file 
                if(!savedGame.isGameEnded()) 
                {
					GameBean emptyGame = new GameBean();
					emptyGame.setUsername(username);
					saveGame(request,username,emptyGame);
				}

				return savedGame;

            } 
            catch (IOException e) 
            {
				e.printStackTrace();
            } 
            catch (ClassNotFoundException e) 
            {
				e.printStackTrace();
			}
		}

		return null;
	}

    // saves game, creates .ser file extension
    private void saveGame(HttpServletRequest request, String username, GameBean gameBean) 
    {
		FileOutputStream outputStream;
		username = username.toLowerCase();

        try 
        {
			// creates file
			outputStream = new FileOutputStream(getServletContext().getRealPath("/WEB-INF/savedgames/" + username + ".ser"));

            if(outputStream != null) 
            {
				ObjectOutputStream out = new ObjectOutputStream(outputStream);
				out.writeObject(gameBean);
				out.close();
			}

			outputStream.close();

        } 
        catch (FileNotFoundException e1) 
        {
			e1.printStackTrace();
        } 
        catch (IOException e) 
        {
			e.printStackTrace();
		}
	}
}